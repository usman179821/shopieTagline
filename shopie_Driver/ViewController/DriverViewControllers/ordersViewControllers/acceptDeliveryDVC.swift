//
//  acceptDeliveryDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 17/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class acceptDeliveryDVC: UIViewController {
    
    @IBOutlet weak var acceptGigsTableView: UITableView!
    
    lazy var availableDeliveryArray = [orderActiveModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availableDeliverysetup()
        // Do any additional setup after loading the view.
    }
    
    
    //accept delivery
    @objc func acceptDeliveryBtnTapped(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "orderInformationDVC") as! orderInformationDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func availableDeliverysetup(){
        //let userID = UserDefaults.standard.array(forKey: SessionManager.Shared.userIdDriver)
        let body :[String:Any] = [
            // "userid": userID ,
            "userid": "5f6783aec74f2",
            "lat": "latitude",
            "lang": "longitude",
            "apikey": "shopie_AC4I_BD"
            
            
        ]
        
        AvailableDelivery(param: body)
        
    }
    
    //MARK:- Api
    private func AvailableDelivery(param:[String:Any]) {
        Alamofire.request(availbaleDeleveryDUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
                if response.result.error == nil {
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                
                                guard let data = jsonDic["data"]?.array else {return}
                                for item in data  {
                                    guard let dataDic = item.dictionary else {return}
                                    let orderID = dataDic["orderid"]?.string ?? ""
                                    let customerid = dataDic["customerid"]?.string ?? ""
                                    let merchantid = dataDic["merchantid"]?.string ?? ""
                                    let driverid = dataDic["driverid"]?.string ?? ""
                                    let orderplaceddate = dataDic["orderplaceddate"]?.string ?? ""
                                    //.........
                                    guard let productArray = dataDic["products"]?.array else {return}
                                    for  item2 in productArray {
                                        guard let ProductDic = item2.dictionary else {return}
                                        let productid = ProductDic["productid"]?.string ?? ""
                                        let productName = ProductDic["productname"]?.string ?? ""
                                        ///....
                                        let SalesTax = dataDic["SalesTax"]?.double ?? 0.00
                                        guard let merchantDic = dataDic["merchant"]?.dictionary else {return}
                                        let merchantName = merchantDic["name"]?.string ?? ""
                                        
                                        //.....
                                        guard let businessDic = merchantDic["business"]?.dictionary else {return}
                                        
                                        let businessname = businessDic["businessname"]?.string ?? ""
                                        //                                            "userid": "5f649cbf84cfc",
                                        //                                                           "name": "Muhammad Naeem",
                                        //                                                           "username": "",
                                        //                                                           "phone": "+923200408234",
                                        //                                                           "email": "Naeem3@gmail.com",
                                        //                                                           "password": "123456",
                                        //                                                           "role": "MERCHANT",
                                        //                                                           "fbid": "",
                                        //                                                           "googleid": "",
                                        guard let customerDic = dataDic["customer"]?.dictionary else {return}
                                        
                                        //..............
                                        
                                        let object1 = orderActiveModel.init(orderID: nil, customerID: nil, merchantID: nil, driverID: nil, productID: nil, productName: productName, ProductQuantity: nil, orderPlacedDate: nil, bussinessName: businessname, totalcost: nil, customerName: nil,merchantName: merchantName)
                                        self.availableDeliveryArray.append(object1)
                                        
                                        
                                        
                                    }
                                    
                                    //                                        let object = orderActiveModel.init(orderPlacedDate: orderplaceddate)
                                    //                                        self.getActiveOrderArray.append(object)
                                    
                                }
                                
                                self.acceptGigsTableView.reloadData()
                            }
                            
                        }catch let jsonErr{
                            print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Login", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Login", body: "Please Enter the right credential")
                    }
                } else {
                    print(response.result.error?.localizedDescription as Any)
                }
        }
    }
    
    
}

extension acceptDeliveryDVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableDeliveryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AvailableGigsCell
       // cell.electronicsImg.image = electronisImg[indexPath.row]
        cell.electronicsTitleNameLbl.text = availableDeliveryArray[indexPath.row].productName
        cell.nameLbl.text = availableDeliveryArray[indexPath.row].merchantName
//        cell.milesAwayImg.image = milawayImg[indexPath.row]
//        cell.mileawayNameLbl.text = milawayData[indexPath.row]
//        cell.pickUpLbl.image = pickupImage[indexPath.row]
//        cell.pickNameLbl.text = pickUpData[indexPath.row]
        cell.acceptDeliveryBtn.tag = indexPath.row
        cell.acceptDeliveryBtn.addTarget(self, action: #selector(acceptDeliveryBtnTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
