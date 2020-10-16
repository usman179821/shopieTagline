//
//  ProfileDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class ProfileDVC: UIViewController {
    
    @IBOutlet weak var viewProfileBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationLeftIcon()
        navigationRightIcon()
    }
    func navigationLeftIcon(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(leftNavigation(sender:)))
        
    }
    
    @objc func leftNavigation(sender: UIBarButtonItem) {
        // Function body goes here
    }
    func navigationRightIcon(){
        let menuButton = UIBarButtonItem(image: UIImage(named: "logout")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(RightNavigation(sender:)))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func RightNavigation(sender: UIBarButtonItem) {
        // Function body goes here
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let VC = SB.instantiateViewController(withIdentifier: "LoginDVC") as! LoginDVC
        let nav = UINavigationController(rootViewController: VC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
    
    
    
    @IBAction func bankInfoBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "bankInfoDVC") as! bankInfoDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        print("Your tab succefully")
        
        let vc = storyboard?.instantiateViewController(identifier: "EditProfileDVC") as! EditProfileDVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "notificationsDVC") as! notificationsDVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
