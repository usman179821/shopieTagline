//
//  LoginMarVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import FBSDKLoginKit
import SwiftyJSON
import Toast_Swift
import GoogleSignIn
import AuthenticationServices

class LoginMarVC: UIViewController {
    
    //MARK:- outlets
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var hideOrUnhidePasswordBtn: UIButton!
    
    //MARK:- Properties and Variables
    var messageLogIn = ""
    var iconClicked = true
    let appleProvider = AppleSignInClient()
    
    //MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.shadow()
        //MARK:- top navigation
        navigationSetup()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func switchBtnTapped(_ sender: UISwitch) {
        if (sender.isOn == true) {
                   UserDefaults.standard.set(true, forKey: "rememberMeMerchant")


               } else {


               }
    }
    func navigationSetup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forgot your credentials?", style: .done, target: self, action: #selector(action(sender:)))
    }
    //Adding functionality top title navigation bar
    @objc func action(sender: UIBarButtonItem) {
       
        showSwiftMessageWithParams(theme: .info, title: "Login", body: "Forgot password screen not available")
    }
    
    //MARK:- Actions
    @IBAction func appleBtnTapped(_ sender: Any) {
        
             
             appleProvider.handleAppleIdRequest(block: { fullName, email, token in
                 // receive data in login class.
                 
             })
         }
    
    
    @IBAction func FbBtnTapped(_ sender: Any) {
        
        fbLogin()
        
    }
    @IBAction func googleBtnTapped(_ sender: Any) {
        print("Going to sign in through google ")
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func passwordHideBtnTapped(_ sender: UIButton) {
        if(iconClicked == true) {
            passwordTextField.isSecureTextEntry = false
            sender.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            sender.setImage(#imageLiteral(resourceName: "eyePassword"), for: .normal)
            
        }
        
        iconClicked = !iconClicked
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        let SB = UIStoryboard(name: "Marchant", bundle: nil)
        
        let vc = SB.instantiateViewController(identifier: "SignupMarVC") as! SignupMarVC
        self.navigationController?.pushViewController(vc, animated: true)
        //   self.view.makeToast("Show Toast Message",duration: 3.0, position: .top )
    }
    
    //MARK:- actions
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        if emailTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Login", body: "Please enter the email field")
            
        }else if passwordTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Login", body: "Please enter the password field")
            
        }else {
            
            let body :[String:Any] = [
                "email":emailTextField.text!,
                "password":passwordTextField.text!,
                "apikey":"shopie_AC4I_BD",
                
            ]
            
            loginApiCall(param: body)
            
        }
    }
    
    //MARK:- Private Functions
    private func loginApiCall(param:[String:Any]) {
        Alamofire.request(loginUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
                if response.result.error == nil {
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                self.messageLogIn = jsonDic["message"]?.string ?? ""
                                showSwiftMessageWithParams(theme: .info, title: "Login", body: self.messageLogIn)
//                                guard let data = jsonDic["data"]?.dictionary else {return}
//                                let userID = data["userid"]?.string ?? ""
//                                UserDefaults.standard.set(userID, forKey: SessionManager.Shared.userIDMarchant)
                                if self.messageLogIn == "user logged in" {
                                    let SB = UIStoryboard(name: "Marchant", bundle: nil)
                                    let VC = SB.instantiateViewController(withIdentifier: "TabBarMarConroller") as! TabBarMarConroller
                                    
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.window?.rootViewController = VC
                                    ///
                                    
                                }
                                
                                
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


//MARK:- social logins
extension LoginMarVC {
    //TODO:- Login with facebook
    
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
                self.fbLoginApi(param: body)
                //                print(result!.token?.tokenString)
                //
                //                print("Cancel")
            }
        }
        
        
    }
    
    private func fbLoginApi(param:[String:Any]) {
        Alamofire.request(socialLoginUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response)
                //   print(response.response?.statusCode)
                if response.result.error == nil {
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                self.messageLogIn = jsonDic["message"]?.string ?? ""
                                showSwiftMessageWithParams(theme: .info, title: "Login", body: self.messageLogIn)
                                guard let data = jsonDic["data"]?.dictionary else {return}
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

