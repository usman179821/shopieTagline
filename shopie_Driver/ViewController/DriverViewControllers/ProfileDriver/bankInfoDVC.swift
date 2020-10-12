//
//  bankInfoDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class bankInfoDVC: UIViewController {

    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Bank Info"
        self.saveBtn.shadow()

   
    }
    

    @IBAction func saveBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "payHistoryDVC") as! payHistoryDVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
