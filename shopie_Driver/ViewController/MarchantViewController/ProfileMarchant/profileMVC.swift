//
//  profileMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 15/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class profileMVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   navigationRightIcon()
        // Do any additional setup after loading the view.
    }
    
    func navigationRightIcon(){
        let menuButton = UIBarButtonItem(image: UIImage(named: "logout")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(RightNavigation(sender:)))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    

    @objc func RightNavigation(sender: UIBarButtonItem) {
        let SB = UIStoryboard(name: "Marchant", bundle: nil)
               let VC = SB.instantiateViewController(withIdentifier: "LoginMarVC") as! LoginMarVC
               let nav = UINavigationController(rootViewController: VC)
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.window?.rootViewController = nav

    }
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "editProfileMVC") as! editProfileMVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bankInfoBtnTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "bankInfoMVC") as! bankInfoMVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "notificationMVC") as! notificationMVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
