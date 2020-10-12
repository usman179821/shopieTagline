//
//  DeliverdMarVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class DeliverdMarVC: UIViewController {
    
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
        // Function body goes here
        let SB = UIStoryboard(name: "Marchant", bundle: nil)
        let VC = SB.instantiateViewController(withIdentifier: "LoginMarVC") as! LoginMarVC
        let navVC = UINavigationController(rootViewController: VC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navVC
    }
    @IBAction func askQuestionBtnTapped(_ sender: Any) {
        
       let SB = UIStoryboard(name: "Marchant", bundle: nil)
               let VC = SB.instantiateViewController(withIdentifier: "LoginMarVC") as! LoginMarVC
               let navVC = UINavigationController(rootViewController: VC)
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.window?.rootViewController = navVC
        showSwiftMessageWithParams(theme: .success, title: "ask Questin", body: "succefully SignUp")
        
    }
    
    
}
