//
//  acceptOrderDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 01/03/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import  Alamofire
import SwiftyJSON

class acceptOrderDVC: UIViewController {
    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewShadow: UIView!
    @IBOutlet weak var topRoundView: UIView!
    @IBOutlet weak var startEarningBtn: UIButton!
    
    var acceptOrderArray = [orderActiveModel]()
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Order Information"
        leadingCon.constant = 0
        //startEarningBtn.shadow()
        topRoundView.RoundSpecificTopCorner()
        swiping()
        bottomViewShadow.shadowTop()
    }
    
    //Mark:- Swipe Function
    
    func swiping (){
        let Rightswipe = UISwipeGestureRecognizer(target: self, action: #selector(self.RespondtoGesture))
        Rightswipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(Rightswipe)
        
    }
    
    @objc func RespondtoGesture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction{
            
        case UISwipeGestureRecognizer.Direction.right:
            print("Swip right")
            swipRight()
        default:
            break
        }
    }
    
    private func swipRight(){
        leadingCon.constant = 300
        //      newShadowView.alpha = 0.3
        //   newShadowView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func acceptOrdertapped(_ sender: Any) {
        
        //  showSwiftMessageWithParams(theme: .info, title: "Order Information", body: "Order Accepted")
        let body :[String:Any] = [
            "driverid": acceptOrderArray[0].driverID,
            "orderid": acceptOrderArray[0].orderID,
            //                "driverid": "5f64fbbca9136",
            //                "orderid": "5f6cc867cf8c4",
            "apikey":"shopie_AC4I_BD",
            
        ]
        print(body)
        acceptOrder(param: body)
        leadingCon.constant = 300
    }
    
    
    
    //MARK:- Private Functions
    private func acceptOrder(param:[String:Any]) {
        AF.request(acceptOrderDUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
               
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                self.message = jsonDic["message"]?.string ?? ""
                                showSwiftMessageWithParams(theme: .info, title: "Order Information", body: self.message)
                                let vc = self.storyboard?.instantiateViewController(identifier: "orderPickupConfirmDVC") as! orderPickupConfirmDVC
                                vc.pickUpOrderArray = self.acceptOrderArray
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                                
                            }
                            
                        }catch let jsonErr{
                            print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Order Information", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Order Information", body: "Something is not working")
                    }
               
        }
    }
    
}
