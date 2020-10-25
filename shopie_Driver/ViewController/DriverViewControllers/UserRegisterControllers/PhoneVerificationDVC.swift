//
//  PhoneVerificationDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhoneVerificationDVC: UIViewController {
    @IBOutlet weak var verifyCodeBtn: UIButton!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var oneTextField: UITextField!
    @IBOutlet weak var twoTextField: UITextField!
    @IBOutlet weak var threeTextField: UITextField!
    @IBOutlet weak var fourTextField: UITextField!
    @IBOutlet weak var numberLbl: UILabel!
    
    var message = ""
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Phone Verification"
        verifyCodeBtn.shadow()
        oneTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        twoTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        threeTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        fourTextField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        let phone = UserDefaults.standard.string(forKey: SessionManager.Shared.phone)
        self.phoneLbl.text = phone
        
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PhoneVerificationDVC.update), userInfo: nil, repeats: true)
    }
    @objc func update() {
        seconds -= 1
            numberLbl.text = ": 00:" + "\(seconds)"  + "s"
        if seconds == 0 {
            seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
                numberLbl.text = "\(seconds)"
        }
    }
    
    @IBAction func resendCodeBtnTapped(_ sender: Any) {
       seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
       numberLbl.text = "\(seconds)"
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
        
        if oneTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Phone Verification", body: "Please fill all fields")
            oneTextField.becomeFirstResponder()
            
        }else if twoTextField.text!.isEmpty{
             showSwiftMessageWithParams(theme: .info, title: "Phone Verification", body: "Please fill all fields")
            twoTextField.becomeFirstResponder()
        }else if threeTextField.text!.isEmpty {
             showSwiftMessageWithParams(theme: .info, title: "Phone Verification", body: "Please fill all fields")
            threeTextField.becomeFirstResponder()
        }else if fourTextField.text!.isEmpty{
             showSwiftMessageWithParams(theme: .info, title: "Phone Verification", body: "Please fill all fields")
            fourTextField.becomeFirstResponder()
        }else {
            verifyByNumber()
        }
        
    }
}

extension PhoneVerificationDVC {
    
    
    func verifyByNumber(){
        
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
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
        AF.request(otpVerifyUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: self.message)
                            if self.message == "Incorrect code" {
                                showSwiftMessageWithParams(theme: .info, title: "Phone Verification", body: "please enter the valid code")
                            }else {
                            
                            let checkStoryBoard = UIStoryboard (name: "Main", bundle: nil)
                            let partner = checkStoryBoard.instantiateViewController(withIdentifier: "CompleteProfileDVC") as! CompleteProfileDVC
                            self.navigationController?.pushViewController(partner, animated: true)
                                self.setPhoneVerified()
                                
                            }
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please Enter the right credential")
                }
           
        }
    }
}

extension PhoneVerificationDVC {
    
    
    func setPhoneVerified(){
        
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
        let body :[String:Any] = [
            "userid": userID ?? "",
            "apikey": "shopie_AC4I_BD"
            
        ]
        
        print(body)
        donePhoneVerify(param: body)
        
    }
    //TODO :- API Calling
    private func donePhoneVerify(param:[String:Any]) {
        AF.request(setPhoneVerifiedUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: self.message)
                            
                            
                            
                            
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please Enter the right credential")
                }
           
        }
    }
}
