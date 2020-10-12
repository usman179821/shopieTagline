//
//  hoorayDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class hoorayDVC: UIViewController {

    @IBOutlet weak var startnewBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startnewBtn.shadow()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startNewJobBtnTapped(_ sender: Any) {
      let SB = UIStoryboard(name: "Main", bundle: nil)
             let VC = SB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
             
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
             appDelegate.window?.rootViewController = VC
    }
    
   

}
