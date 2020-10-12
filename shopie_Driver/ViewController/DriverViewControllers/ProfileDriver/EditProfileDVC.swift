//
//  EditProfileDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class EditProfileDVC: UIViewController {
    
    @IBOutlet weak var updateInfoBtn: UIButton!
    @IBOutlet weak var showProfileImage: UIImageView!
    @IBOutlet weak var selectImage: UIButton!
    
    
        //MARK: Properties
    
    var imagePicker = UIImagePickerController()
    private var currentImageViewForImagePicking: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationItem.title = "Edit Profile"
        self.updateInfoBtn.shadow()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateInfoTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "EarningDVC") as! EarningDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func addProfileImageTapped(_ sender: Any) {
        
        
        currentImageViewForImagePicking = showProfileImage
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
}


//MARK: Image Picker Extensions
extension EditProfileDVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        currentImageViewForImagePicking?.image  = tempImage
        if currentImageViewForImagePicking == showProfileImage{
            //profileImageBGView.isHidden = true
            showProfileImage.layer.cornerRadius = 8
            showProfileImage.layer.masksToBounds = true
           // profilePhotImageView.layer.cornerRadius = 50
        }

        picker.dismiss(animated: true) {
//            print(<#T##items: Any...##Any#>)
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
//            <#code#>
        }
    }

}
