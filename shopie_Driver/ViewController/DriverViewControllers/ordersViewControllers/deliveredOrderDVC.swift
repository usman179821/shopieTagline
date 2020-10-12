//
//  deliveredOrderDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class deliveredOrderDVC: UIViewController {
    @IBOutlet weak var deliveredBtn: UIButton!
    @IBOutlet weak var navigateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateBtn.borderColor1()
        deliveredBtn.shadow()

        // Do any additional setup after loading the view.
    }
    @IBAction func navigateBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "mapViewOrderDVC") as! mapViewOrderDVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deliveredBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "completeOrderDVC") as! completeOrderDVC
        self.navigationController?.pushViewController(vc, animated: true)
        showSwiftMessageWithParams(theme: .info, title: "Order Information", body: "Order Delivered")
        
    }
    

}
