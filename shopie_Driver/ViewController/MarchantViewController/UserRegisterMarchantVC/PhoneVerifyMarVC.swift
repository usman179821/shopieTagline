//
//  PhoneVerifyMarVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhoneVerifyMarVC: UIViewController {
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var verifyCodeBtn: UIButton!
    @IBOutlet weak var oneTextField: UITextField!
    @IBOutlet weak var twoTextField: UITextField!
    @IBOutlet weak var threeTextField: UITextField!
    @IBOutlet weak var fourTextField: UITextField!
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let phone = UserDefaults.standard.string(forKey: SessionManager.Shared.phone)
        self.phoneLbl.text = phone
        
        
        verifyCodeBtn.shadow()
        oneTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        twoTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        threeTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fourTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textfield: UITextField){
        let text = textfield.text
        if text?.utf16.count == 1 {
            switch textfield {
            case oneTextField:
                twoTextField.becomeFirstResponder()
            case twoTextField:
                threeTextField.becomeFirstResponder()
            case threeTextField:
                fourTextField.becomeFirstResponder()
            case fourTextField:
                fourTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        oneTextField.becomeFirstResponder()
    }
    
    @IBAction func verifyBtnTapped(_ sender: Any) {
        verifyByNumber()
    }
}

extension PhoneVerifyMarVC {
    
    func verifyByNumber(){
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant)
        let body :[String:Any] = [
            "userid": userID ??  "",
            "code": oneTextField.text! + twoTextField.text! + threeTextField.text! + fourTextField.text!,
            "apikey": "shopie_AC4I_BD"
            
        ]
        
        print(body)
        verificationCode(param: body)
        
    }
    //TODO :- API Calling
    private func verificationCode(param:[String:Any]) {
        Alamofire.request(otpVerifyUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "Phone Verify", body: self.message)
                            
                            
                            let checkStoryBoard = UIStoryboard (name: "Marchant", bundle: nil)
                            let partner = checkStoryBoard.instantiateViewController(withIdentifier: "CompleteProfileMarVC") as! CompleteProfileMarVC
                            self.navigationController?.pushViewController(partner, animated: true)
                            self.setPhoneVerified()
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "Phone Verify", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "Phone Verify", body: "Please Enter the right credential")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}

extension PhoneVerifyMarVC {
    
    
    func setPhoneVerified(){
        
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant)
        let body :[String:Any] = [
            "userid": userID ?? "",
            "apikey": "shopie_AC4I_BD"
            
        ]
        
        print(body)
        donePhoneVerify(param: body)
        
    }
    //TODO :- API Calling
    private func donePhoneVerify(param:[String:Any]) {
        Alamofire.request(setPhoneVerifiedUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "Phone Verify", body: self.message)
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "Phone Verify", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "Phone Verify", body: "Please Enter the right credential")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}
