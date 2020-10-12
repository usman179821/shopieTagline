//
//  CompleteProfileDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class CompleteProfileDVC: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var uploadDriverImg: UIImageView!
    @IBOutlet weak var ssnNumberTextfield: HoshiTextField!
    @IBOutlet weak var driverLicenseTextField: HoshiTextField!
    @IBOutlet weak var issuedDateTextField: HoshiTextField!
    @IBOutlet weak var expireDateTextField: HoshiTextField!
  
    @IBOutlet weak var frontImg: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    
    //MARK:- variables
    var message = ""
    var profileImage = UIImage()
    var imagePicker = UIImagePickerController()
    private var currentImageViewForImagePicking: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.shadow()
        setUpImageView()
        spinner.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        if uploadDriverImg.image == nil {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please Upload Driver Image")
        }
        else if ssnNumberTextfield.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please Enter Last 4 digits SSN Numbers ")
            
        }
        else if driverLicenseTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "please Enter Driving License Number ")
            
        }else if issuedDateTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "please Enter Issue Date")
            
        }
        else if expireDateTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please Enter Expres On")
            
        }else if frontImg.image == nil {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please upload driver Lisence front side photo")
        }else if backImg.image == nil {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please upload driver Lisence back side photo")
        }
        else {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
            let imageString = convertImageToBase64String(img: uploadDriverImg?.image ?? UIImage())
           // let imageString = convertImageToBase64String(img: profileImage)
            let frontImageStaring = convertImageToBase64String(img: frontImg?.image ?? UIImage())
            let backImageStaring =  convertImageToBase64String(img: backImg?.image ?? UIImage())

            let userid = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver) ?? ""
            let body :[String:Any] = [
                
                "userid": userid,
                "ssn": ssnNumberTextfield.text!,
                "license": driverLicenseTextField.text!,
                "issuedate": issuedDateTextField.text!,
                "expirydate": expireDateTextField.text!,
                "state": "CA",
                "profileimage":imageString,
                "licensefront":frontImageStaring,
                "licenseback":backImageStaring,
                "apikey": "shopie_AC4I_BD",
                
                
            ]
           
           
            completeProfileAPi(param: body)
            
        }
    }
    
    //TODO :- API Calling
    private func completeProfileAPi(param:[String:Any]) {
        self.spinner.isHidden = false
                   self.spinner.startAnimating()
        Alamofire.request(completeDriverTransportUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            self.spinner.isHidden = true
                       self.spinner.stopAnimating()
            //print(response)
          //  print("Request: \(String(describing: response.request))")   // original url request
          //  print("Response: \(String(describing: response.response))") // http url response
          //  print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: self.message)
                            if self.message == "Driver profile setup"{
                                let vc = self.storyboard?.instantiateViewController(identifier: "DeliveredDVC") as! DeliveredDVC
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "Complete Profile", body: "Please Enter the right credential")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}

//MARK: Image Picker Extensions
extension CompleteProfileDVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        currentImageViewForImagePicking?.image  = tempImage
        if currentImageViewForImagePicking == uploadDriverImg{
            
            
        }

        picker.dismiss(animated: true) {
//            print(T##items: Any...##Any)
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
//            <#code#>
        }
    }
    
    func setUpImageView(){
        uploadDriverImg.isUserInteractionEnabled = true
        let profilePhotoTap = UITapGestureRecognizer(target: self, action: #selector(handleProfilePhotoTap(_:)))
        uploadDriverImg.addGestureRecognizer(profilePhotoTap)
        //Front
        frontImg.isUserInteractionEnabled = true
        let profilePhotoTap2 = UITapGestureRecognizer(target: self, action: #selector(handleProfilePhotoTap(_:)))
        frontImg.addGestureRecognizer(profilePhotoTap2)
        //back
        backImg.isUserInteractionEnabled = true
        let profilePhotoTap3 = UITapGestureRecognizer(target: self, action: #selector(handleProfilePhotoTap(_:)))
        backImg.addGestureRecognizer(profilePhotoTap3)
        
        frontImg.imageround()
        backImg.imageround()
    }
    
    //Handle Multiple Images
    
    @objc private func handleProfilePhotoTap(_ sender: UITapGestureRecognizer){
        
        currentImageViewForImagePicking = sender.view as? UIImageView
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
    //convert Image base64 encode or decode
    func convertImageToBase64String (img: UIImage) -> String {
          return img.jpegData(compressionQuality: 0)?.base64EncodedString() ?? ""
      }
      //Decoding
      
      func convertBase64StringToImage (imageBase64String:String) -> UIImage {
          let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
          let image = UIImage(data: imageData!)
          return image!
      }
    
    

}

