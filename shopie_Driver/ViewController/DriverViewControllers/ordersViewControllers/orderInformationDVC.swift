//
//  orderInformationDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class orderInformationDVC: UIViewController {
    
    @IBOutlet weak var startEarningBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Order Information"
        startEarningBtn.shadow()

    }
    

    @IBAction func startEanringBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "orderPickupConfirmDVC") as! orderPickupConfirmDVC
        
        self.navigationController?.pushViewController(vc, animated: true)
          showSwiftMessageWithParams(theme: .info, title: "Order Information", body: "Order Accepted")
            let body :[String:Any] = [
                
                "driverid": "5f64fbbca9136",
                "orderid": "5f6cc867cf8c4",
                "apikey":"shopie_AC4I_BD",
                
            ]
            
            acceptOrder(param: body)
    }

        //MARK:- Private Functions
        private func acceptOrder(param:[String:Any]) {
            Alamofire.request(acceptOrderDUrl, method: .post, parameters: param, encoding:
                JSONEncoding.default, headers: nil).responseJSON { (response) in
                    print(response)
                    //   print(response.response?.statusCode)
                    if response.result.error == nil {
                        if response.response?.statusCode == 200 {
                            guard let data = response.data else {return}
                            
                            do{
                                
                                if let jsonDic = try JSON (data: data).dictionary {
//                                    self.messageLogIn = jsonDic["message"]?.string ?? ""
//                                    showSwiftMessageWithParams(theme: .info, title: "Login", body: self.messageLogIn)
//                                    guard let data = jsonDic["data"]?.dictionary else {return}
    //                                let userID = data["userid"]?.string ?? ""
    //                                UserDefaults.standard.set(userID, forKey: SessionManager.Shared.userIdSignUp)
                                    
                                    
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

