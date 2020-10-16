//
//  UniversalScreenVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class UniversalScreenVC: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func driverBtnTapped(_ sender: Any) {
        UserDefaults.standard.set("Driver", forKey: SessionManager.Shared.isMerchant)
        setRootViewController(storyBoardId: "Main", viewControllerId: "LoginDVC")
    }
    
    @IBAction func marchantBtnTapped(_ sender: Any) {
        setRootViewController(storyBoardId: "Marchant", viewControllerId: "LoginMarVC")
        UserDefaults.standard.set("Merchant", forKey: SessionManager.Shared.isMerchant)
        
    }
    
}
