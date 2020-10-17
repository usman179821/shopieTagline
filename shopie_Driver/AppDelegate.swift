//
//  AppDelegate.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 23/01/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    
    //MARK:- variables and properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Keyboared setting
        
        //keyboared setting
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //Navigation setting
        //Mark:- for navigation topBar
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = false
        
        //Google sign in setup
        // Initialize sign-in Google
               GIDSignIn.sharedInstance().clientID = "388374304159-6jhreavke0ccsi0319umvdg62prhsr9u.apps.googleusercontent.com"
               GIDSignIn.sharedInstance().delegate = self
        
        
//        
//
        if  UserDefaults.standard.string(forKey: SessionManager.Shared.isMerchant) == "Merchant" {

            setRootViewController(storyBoardId: "Marchant", viewControllerId: "LoginMarVC")

        }else  if  UserDefaults.standard.string(forKey: SessionManager.Shared.isMerchant) == "Driver" {
            setRootViewController(storyBoardId: "Main", viewControllerId: "LoginDVC")

        }else {
            setRootViewController(storyBoardId: "Main", viewControllerId: "UniversalScreenVC")
        }

        let userIDMerchant = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant) ?? ""
        print(userIDMerchant)
         let userIDDriver = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver) ?? ""
        print(userIDDriver, "user ide driver")

        if userIDDriver != "" {
            
           if UserDefaults.standard.bool(forKey: "rememberMe"){
                let SB = UIStoryboard(name: "Main", bundle: nil)
                let VC = SB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = VC
                self.window?.makeKeyAndVisible()
            }else {
                let SB = UIStoryboard(name: "Main", bundle: nil)
                let VC = SB.instantiateViewController(withIdentifier: "LoginDVC") as! LoginDVC
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = VC
                self.window?.makeKeyAndVisible()
            }
            // Show Home Screen
            

        }else if userIDMerchant != "" {
            if UserDefaults.standard.bool(forKey: "rememberMeMerchant") {
            let SB = UIStoryboard(name: "Marchant", bundle: nil)
            let VC = SB.instantiateViewController(withIdentifier: "TabBarMarConroller") as! TabBarMarConroller
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = VC
                self.window?.makeKeyAndVisible()
                
            }else {
                let SB = UIStoryboard(name: "Marchant", bundle: nil)
                let VC = SB.instantiateViewController(withIdentifier: "LoginMarVC") as! LoginMarVC
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = VC
                    self.window?.makeKeyAndVisible()
            }
        }
//
//       
       
        
        
        return true
        
    }
    
   func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
    }
    //Google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        @available(iOS 9.0, *)
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

