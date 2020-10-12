//
//  startDeliveryDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class startDeliveryDVC: UIViewController {
    @IBOutlet weak var deliveredBtn: UIButton!
    @IBOutlet weak var navigateBtn: UIButton!
    
    var passigData = [orderActiveModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateBtn.borderColor1()
        deliveredBtn.shadow()

        // Do any additional setup after loading the view.
    }
    @IBAction func navigateBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "") as! completeOrderDVC
        self.navigationController?.pushViewController(vc, animated: true)
        showSwiftMessageWithParams(theme: .info, title: "Order Information", body: "Delivery in Progress")
            let body :[String:Any] = [
                
                "driverid": "5f64fbbca9136",
                "orderid": "5f6cc867cf8c4",
                "apikey":"shopie_AC4I_BD",
                
            ]
            
            startDeliveryApi(param: body)
    }
    
            //MARK:- Private Functions
            private func startDeliveryApi(param:[String:Any]) {
                Alamofire.request(startDeliveryOrderDUrl, method: .post, parameters: param, encoding:
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
    
    @IBAction func deliveredBtnTapped(_ sender: Any) {
        deliveredBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let vc = storyboard?.instantiateViewController(identifier: "deliveredOrderDVC") as! deliveredOrderDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
