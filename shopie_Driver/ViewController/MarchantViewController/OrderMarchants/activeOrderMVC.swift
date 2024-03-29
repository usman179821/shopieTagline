//
//  activeOrderMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 13/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class activeOrderMVC: UIViewController {
    
    //MARK:- outltes
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var completeTableView: UITableView!
    
    //MARK:- variables and properties
   
    
    lazy var getActiveOrderArray = [orderActiveModel]()
    lazy var completeOrderArray = [orderActiveModel]()
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Orders"
        self.completeTableView.isHidden = true
        segmentCustomise()
        activeOrder()
        completeOrcancelorder()
    }
    
    func segmentCustomise(){
    
    segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
    }
    @IBAction func segmentControlTapped(_ sender: Any) {
        
        let getIndex = segmentControll.selectedSegmentIndex
        print(getIndex)
        switch getIndex {
        case 0:
            self.orderTableView.isHidden = false
            self.completeTableView.isHidden = true
        case 1 :
            self.orderTableView.isHidden = true
            self.completeTableView.isHidden = false
        default:
            print("No Index")
        }
    }
    
    @objc func cancelOrderBtnTapped(_sender: UIButton) {
        
            let body :[String:Any] = [
              
                "userid": "5f649cbf84cfc",
                "orderid": getActiveOrderArray[0].orderID ?? 00,
                "role": "MERCHANT",
                "apikey": "shopie_AC4I_BD"

                
            ]
            
            cancelOrder(param: body)
            
        
    }
    
        //MARK:- Private Functions
        private func cancelOrder(param:[String:Any]) {
            AF.request(cancelOrderMerchantUrl, method: .post, parameters: param, encoding:
                JSONEncoding.default, headers: nil).responseJSON { (response) in
                    print(response)
                    //   print(response.response?.statusCode)
                   
                        if response.response?.statusCode == 200 {
                            guard let data = response.data else {return}
                            
                            do{
                                
                                if let jsonDic = try JSON (data: data).dictionary {
                                    self.message = jsonDic["message"]?.string ?? ""
                                    showSwiftMessageWithParams(theme: .info, title: "Order Information", body: self.message)
    //                                guard let data = jsonDic["data"]?.dictionary else {return}
                                
                                        
                                        
        
                                    
                                    
    //                                let userID = data["userid"]?.string ?? ""
    //                                UserDefaults.standard.set(userID, forKey: SessionManager.Shared.userIdSignUp)
                                    
                                    
                                }
                                
                            }catch let jsonErr{
                                print(jsonErr)
                                
                                showSwiftMessageWithParams(theme: .info, title: "Order Information", body: jsonErr.localizedDescription)
                            }
                            
                        }else {
                            showSwiftMessageWithParams(theme: .error, title: "Order Information", body: "something not working")
                        }
                   
            }
        }
    
    @objc func viewOrderDetailBtnTapped(_sender: UIButton){
        
        let vc = storyboard?.instantiateViewController(identifier: "acceptOrderMVC") as! acceptOrderMVC
        vc.dataArrayAcceptOrder = getActiveOrderArray
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func viewCompleteOrderTapped(_sender: UIButton) {
        print("Complete Order")
        
        let vc = storyboard?.instantiateViewController(identifier: "orderDetailCompleteMVC") as! orderDetailCompleteMVC
        vc.dataArray = completeOrderArray
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func completeOrcancelorder(){
       // let userID = UserDefaults.standard.array(forKey: SessionManager.Shared.userIDMarchant)
        let body :[String:Any] = [
           // "userid": userID ,
            "userid": "5f649cbf84cfc",
          
            "apikey":"shopie_AC4I_BD",
            
        ]
        print(body)
        completOrder(param: body)

    }
    

    //MARK:- Api
    private func completOrder(param:[String:Any]) {
        AF.request(completeOrCancelOrderDUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
                
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
                                        let productctQuantity = ProductDic["quantity"]?.int ?? -1
                                        ///....
                                        let totalcost = dataDic["totalcost"]?.double ?? 0.00
                                        guard let merchantDic = dataDic["merchant"]?.dictionary else {return}
                                        
                                        //.....
                                        guard let businessDic = merchantDic["business"]?.dictionary else {return}
                                        
                                        let businessname = businessDic["businessname"]?.string ?? ""
                                        //                                            "userid": "5f649cbf84cfc",
                                        //                                                           "name": "Muhammad Naeem",
                                        //                                                           "username": "",
                                        
                                        guard let customerDic = dataDic["customer"]?.dictionary else {return}
                                        let customerName = customerDic["name"]?.string ?? ""
                                        
                                        //..............
                                        
                                        let object = orderActiveModel.init(orderID: orderID, customerID: customerid, merchantID: merchantid, driverID: driverid, productID: productid, productName: productName, ProductQuantity: productctQuantity, orderPlacedDate: orderplaceddate, bussinessName: businessname,totalcost: totalcost,customerName: customerName)
                                        self.completeOrderArray.append(object)
                                        print(object)
                                        
                                        
                                    }
                                    
                                   
                                    
                                }
                                
                                self.completeTableView.reloadData()
                            }
                            
                        }catch let jsonErr{
                            print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Orders", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Orders", body: "Something is not working")
                    }
                
        }
    }
//
    func activeOrder(){
         // let userID = UserDefaults.standard.array(forKey: SessionManager.Shared.userIDMarchant)
          let body :[String:Any] = [
             // "userid": userID ,
              "userid": "5f649cbf84cfc",
             
              "apikey":"shopie_AC4I_BD",
              
          ]
          
          activeOrderAPI(param: body)

      }

    //MARK:- Api
    private func activeOrderAPI(param:[String:Any]) {
        AF.request(activeOrderDUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
                
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
                                        let productctQuantity = ProductDic["quantity"]?.int ?? -1
                                        ///....
                                          let totalcost = dataDic["totalcost"]?.double ?? 0.00
                                        guard let merchantDic = dataDic["merchant"]?.dictionary else {return}
                                        
                                        
                                        //.....
                                        guard let businessDic = merchantDic["business"]?.dictionary else {return}
                                        
                                        let businessname = businessDic["businessname"]?.string ?? ""
                                        //                                            "userid": "5f649cbf84cfc",
                                        //                                                           "name": "Muhammad Naeem",
                                        //                                                           "username": "",
                                        
                                        guard let customerDic = dataDic["customer"]?.dictionary else {return}
                                        let customerName = customerDic["name"]?.string ?? ""
                                        
                                        //..............
                                        
                                        let object = orderActiveModel.init(orderID: orderID, customerID: customerid, merchantID: merchantid, driverID: driverid, productID: productid, productName: productName, ProductQuantity: productctQuantity, orderPlacedDate: orderplaceddate, bussinessName: businessname,totalcost: totalcost,customerName: customerName)
                                        self.getActiveOrderArray.append(object)
//                                        let SB = UIStoryboard(name: "Main", bundle: nil)
//                                        let vc = SB.instantiateViewController(identifier: "startDeliveryDVC") as!  startDeliveryDVC
//                                        vc.passigData = self.getActiveOrderArray
//                                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                                        
                                        
                                    }
                                    
                                    //                                        let object = orderActiveModel.init(orderPlacedDate: orderplaceddate)
                                    //                                        self.getActiveOrderArray.append(object)
                                    
                                }
                                
                                self.orderTableView.reloadData()
                            }
                            
                        }catch let jsonErr{
                            print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Login", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Orders", body: "Something is not working")
                    }
              
        }
    }
    
    
}
extension activeOrderMVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orderTableView {
        return getActiveOrderArray.count
        }else {
            return completeOrderArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! activeOrderMCell
        
        if tableView == self.orderTableView {
        let instance = getActiveOrderArray[indexPath.row]
            cell.dateAndTimeLbl.text = instance.orderPlacedDate
            cell.priceLbl.text = "\(instance.totalcost!)"
            cell.nameTitleLbl.text = "\(instance.productName!)" + "\(instance.ProductQuantity!)"
            cell.orderNumberLbl.text = instance.orderID
        cell.cancelBtnTapped.tag = indexPath.row
        cell.cancelBtnTapped.addTarget(self, action: #selector(cancelOrderBtnTapped(_sender:)), for: .touchUpInside)
        cell.viewDetailTapped.addTarget(self, action: #selector(viewOrderDetailBtnTapped(_sender:)), for: .touchUpInside)
        cell.viewDetailTapped.RoundSpecificBottomCornerR()
        cell.cancelBtnTapped.RoundSpecificBottomCornerL()
        }else if tableView == completeTableView {
            let instance = completeOrderArray[indexPath.row]
            cell.dateAndTimeLbl.text = instance.orderPlacedDate
            cell.priceLbl.text = "\(instance.totalcost!)"
            cell.nameTitleLbl.text = "\(instance.productName!)" + "\(instance.ProductQuantity!)"
            cell.orderNumberLbl.text = instance.orderID
           
            cell.viewDetailTapped.addTarget(self, action: #selector(viewCompleteOrderTapped(_sender:)), for: .touchUpInside)
            cell.viewDetailTapped.RoundSpecificBottomCornerLR()
            
            
          
        }
        
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
}
