//
//  readyOrderMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 24/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class readyOrderMVC: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var acceptOrderBtn: UIButton!
    @IBOutlet weak var rejectOrderBtn: UIButton!
    

    //MARK:- variables and properties
    var nameProductArray = ["Apple Smart keyboared for iPAD (7th Generation) and","Apple Smart keyboared for iPAD (7th Generation) and"]
    var priceArray = ["$200.00","$300.00"]
    var priceFormulArray = ["1* -200","2* - 200"]
    var dataArrayReadyOrder = [orderActiveModel]()
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.acceptOrderBtn.borderColor1()
        self.rejectOrderBtn.borderColor1()
        
        //After Tableviews data source values are assigned
        orderTableView.reloadData()
        orderTableView.layoutIfNeeded()
        self.orderTableView.estimatedRowHeight = 100
       // self.orderTableView.rowHeight = UITableView.automaticDimension
        
        
    }
    override func viewDidLayoutSubviews() {
        orderTableView.heightAnchor.constraint(equalToConstant: orderTableView.contentSize.height).isActive = true
    }
    
    @IBAction func acceptOrderBtnTapped(_ sender: Any) {
        
            let body :[String:Any] = [
                
                "orderid": dataArrayReadyOrder[0].orderID ?? 00,
                "apikey":"shopie_AC4I_BD",
                
            ]
            
            readyOrder(param: body)
            
        
    }
    
    
        //MARK:- Private Functions
        private func readyOrder(param:[String:Any]) {
            Alamofire.request(prepareOrderMerchantUrl, method: .post, parameters: param, encoding:
                JSONEncoding.default, headers: nil).responseJSON { (response) in
                    print(response)
                    //   print(response.response?.statusCode)
                    if response.result.error == nil {
                        if response.response?.statusCode == 200 {
                            guard let data = response.data else {return}
                            
                            do{
                                
                                if let jsonDic = try JSON (data: data).dictionary {
                                    self.message = jsonDic["message"]?.string ?? ""
                                    showSwiftMessageWithParams(theme: .info, title: "Order Information", body: self.message)
                                    
                                    let SB = UIStoryboard(name: "Marchant", bundle: nil)
                                    if self.message == "Order is ready"{
                                                let VC = SB.instantiateViewController(withIdentifier: "TabBarMarConroller") as! TabBarMarConroller
                                                
                                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        appDelegate.window?.rootViewController = VC }
    //                                guard let data = jsonDic["data"]?.dictionary else {return}
                                   // let SB = UIStoryboard(name: "Marchant", bundle: nil)
                                 //   let VC = SB.instantiateViewController(withIdentifier: "readyOrderMVC") as! readyOrderMVC
                      //  self.navigationController?.pushViewController(VC, animated: true)
                                    
                                    
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
                    } else {
                        print(response.result.error?.localizedDescription as Any)
                    }
            }
        }
    
    @IBAction func rejectOrderBtnTapped(_ sender: Any) {
    }
    
}
extension readyOrderMVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! detailOrderMCell
        cell.nameLbl.text = nameProductArray[indexPath.row]
        cell.priceLbl.text = priceArray[indexPath.row]
        cell.priceFormulaLbl.text = priceFormulArray[indexPath.row]
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


