//
//  DeliveredDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class DeliveredDVC: UIViewController {
    
    @IBOutlet weak var havequestionBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        havequestionBtn.shadow()
        navigationSetUp()
        //MARK:- top navigation
    }
    
    func navigationSetUp(){
        let menuButton = UIBarButtonItem(image: UIImage(named: "logout")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(action(sender:)))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func action(sender: UIBarButtonItem) {
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let VC = SB.instantiateViewController(withIdentifier: "LoginDVC") as! LoginDVC
        let navVC = UINavigationController(rootViewController: VC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navVC
        // Function body goes here
    }
    @IBAction func askQuestionBtnTapped(_ sender: Any) {
        
         let SB = UIStoryboard(name: "Main", bundle: nil)
               let VC = SB.instantiateViewController(withIdentifier: "LoginDVC") as! LoginDVC
               let navVC = UINavigationController(rootViewController: VC)
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.window?.rootViewController = navVC
        showSwiftMessageWithParams(theme: .success, title: "ask Questin", body: "succefully SignUp")
    }
    
    
}
