//
//  SignUpDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON
import Alamofire
import FBSDKLoginKit
import Toast_Swift
import GoogleSignIn
import AuthenticationServices

class SignUpDVC: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var termsBoxBtn: UIButton!
    @IBOutlet weak var verifyNameImage: UIImageView!
    @IBOutlet weak var emailTxtField: HoshiTextField!
    @IBOutlet weak var fullNameTxtField: HoshiTextField!
    @IBOutlet weak var phoneNumbertxtField: HoshiTextField!
    @IBOutlet weak var passwordTxtField: HoshiTextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    //MARK:- variable And properties
    var iconClicked = true
    var checkBoxClicked = true
    var messageSignUp = ""
    var message = ""
    var messageLogIn = ""
    let appleProvider = AppleSignInClient()
    
    //MARK:- view life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- top navigation
        
        signupBtn.shadow()
        navigationSetUp()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
               
               // Automatically sign in the user.
               GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func navigationSetUp(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "need some help?", style: .done, target: self, action: #selector(action(sender:)))
    }
    //Adding functionality top title navigation bar
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
        showSwiftMessageWithParams(theme: .info, title: "Signup", body: "Need some help screen not available yet")
        
    }
    
    //MARK:- Actions
    @IBAction func hideUnhideBtnTapped(_ sender: UIButton) {
        if(iconClicked == true) {
            passwordTxtField.isSecureTextEntry = false
            sender.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        } else {
            passwordTxtField.isSecureTextEntry = true
            sender.setImage(#imageLiteral(resourceName: "eyePassword"), for: .normal)
            
        }
        
        iconClicked = !iconClicked
    }
    
    @IBAction func acceptTermsBtnTapped(_ sender: UIButton) {
        if(checkBoxClicked == true) {
            sender.setImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            
        } else if (checkBoxClicked == false) {
            sender.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        }
        
        checkBoxClicked = !checkBoxClicked
    }
    @IBAction func appleBtnTapped(_ sender: Any) {
    
         
         appleProvider.handleAppleIdRequest(block: { fullName, email, token in
             // receive data in login class.
             
             
             
         })
    
     
     }
    @IBAction func faceBookBtnTabbed(_ sender: Any) {
        fbLogin()
    }
    
    @IBAction func googleBtnTapped(_ sender: Any) {
       
        print("Going to sign in through google ")
        GIDSignIn.sharedInstance().signIn()
    }
    func fbLogin(){
        
        LoginManager().logIn(permissions: ["public_profile","email"], from: self) { (result, err) in
            if err != nil {
                print("Facebook login Failed",err!)
                return
            }else{
                let body :[String:Any] = [
                    "fbid": result?.token?.tokenString ?? "",
                    "apikey":"shopie_AC4I_BD",
                    
                ]
                print(body)
              //  self.fbLoginApi(param: body)
                //                print(result!.token?.tokenString)
                //
                //                print("Cancel")
            }
        }

//             func fbLoginApi(param:[String:Any]) {
//                Alamofire.request(socialLoginUrl, method: .post, parameters: param, encoding:
//                    JSONEncoding.default, headers: nil).responseJSON { (response) in
//                        print(response)
//                        //   print(response.response?.statusCode)
//                        if response.result.error == nil {
//                            if response.response?.statusCode == 200 {
//                                guard let data = response.data else {return}
//
//                                do{
//
//                                    if let jsonDic = try JSON (data: data).dictionary {
//                                        self.messageLogIn = jsonDic["message"]?.string ?? ""
//                                        showSwiftMessageWithParams(theme: .info, title: "Login", body: self.messageLogIn)
//                                        guard let data = jsonDic["data"]?.dictionary else {return}
//        //                                let userID = data["userid"]?.string ?? ""
//        //                                UserDefaults.standard.set(userID, forKey: SessionManager.Shared.userIdSignUp)
//
//
//                                    }
//
//                                }catch let jsonErr{
//                                    print(jsonErr)
//
//                                    showSwiftMessageWithParams(theme: .info, title: "Login", body: jsonErr.localizedDescription)
//                                }
//
//                            }else {
//                                showSwiftMessageWithParams(theme: .error, title: "Login", body: "Please Enter the right credential")
//                            }
//                        } else {
//                            print(response.result.error?.localizedDescription as Any)
//                        }
//                }
//            }
        
        
    }
    
    
    @IBAction func termsAndConditionBtnTapped(_ sender: Any) {
        showSwiftMessageWithParams(theme: .info, title: "Terms & Conditions", body: "Terms and condition screen not available yet")
    }
    @IBAction func signInBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LoginDVC") as! LoginDVC
        // showToast(message: "hi ", seconds: 1.0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        if emailTxtField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: "Please enter email ")
            emailTxtField.becomeFirstResponder()
            
        }
        else if fullNameTxtField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: "Please Enter your full name")
            fullNameTxtField.becomeFirstResponder()
            
        }else if phoneNumbertxtField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: "Please Enter your phone number")
            phoneNumbertxtField.becomeFirstResponder()
            
        }
        else if passwordTxtField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "SignUp ", body: "Please enter your password")
            passwordTxtField.becomeFirstResponder()
            
        }else if  checkBoxClicked == true  {
            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: "Please accept terms & condition")
            
        }
        else {
            let body :[String:Any] = [
                "name": fullNameTxtField.text!,
                "email": emailTxtField.text!,
                "phone": phoneNumbertxtField.text!,
                "role": "DRIVER",
                "password": passwordTxtField.text!,
                "apikey": "shopie_AC4I_BD"
                
            ]
            
            print(body)
            signupApiCall(param: body)
            
        }
    }
    
    //TODO :- API Calling
    private func signupApiCall(param:[String:Any]) {
        Alamofire.request(signupUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
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
                            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: self.message)
                            guard let user = jsonDic["user"]?.dictionary else {return}
                            let phone = user["phone"]?.string ?? ""
                            UserDefaults.standard.set(phone, forKey: SessionManager.Shared.phone)
                            let signupUserIDdriver = user["userid"]?.string ?? ""
                            
                            UserDefaults.standard.set(signupUserIDdriver, forKey: SessionManager.Shared.userIdDriver)
                            if self.message == "User with same email already exists" {
                                let vc = self.storyboard?.instantiateViewController(identifier: "TransportationDVC") as! TransportationDVC
                                self.navigationController?.pushViewController(vc, animated: true)
                                showSwiftMessageWithParams(theme: .info, title: "SignUp", body: "Please complete the transpotation detail")
                                
                                
                            }else
                            {
                                self.verifyByNumber()
                                
                            }
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please enter the right credentials")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}
extension SignUpDVC {
    
    
    func verifyByNumber(){
        
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
        let body :[String:Any] = [
            "userid": userID ?? "",
            "phone": phoneNumbertxtField.text!,
            "apikey": "shopie_AC4I_BD"
            
        ]
        
        print(body)
        verificationCode(param: body)
        
    }
    //TODO :- API Calling
    private func verificationCode(param:[String:Any]) {
        Alamofire.request(verifyByNumberUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            //                            self.message = jsonDic["message"]?.string ?? ""
                            //                            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: self.message)
                            showSwiftMessageWithParams(theme: .info, title: "Shopie", body: "Code sent....")
                            
                            let checkStoryBoard = UIStoryboard (name: "Main", bundle: nil)
                            let partner = checkStoryBoard.instantiateViewController(withIdentifier: "PhoneVerificationDVC") as! PhoneVerificationDVC
                            self.navigationController?.pushViewController(partner, animated: true)
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please enter the right credentials")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}
