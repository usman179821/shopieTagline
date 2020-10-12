//
//  CompleteProfileMarVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class CompleteProfileMarVC: UIViewController {
    @IBOutlet weak var spinneActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var uploadProfileImage: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var businessNameTextField: HoshiTextField!
    @IBOutlet weak var businessAddressTextField: HoshiTextField!
    @IBOutlet weak var cityTextField: HoshiTextField!
    @IBOutlet weak var stateTextField: HoshiTextField!
    @IBOutlet weak var aboutBusinessTextView: UITextView!
    
    
    var message = ""
    var profileImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.shadow()
        spinneActivity.isHidden = true
        // uploadProfileImage.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        uploadProfileImage.isUserInteractionEnabled = true
        uploadProfileImage.addGestureRecognizer(tapGestureRecognizer)
    }
   
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        if businessNameTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "Please Enter Business Name ")
            
        }
        else if businessAddressTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "please Enter Business Address")
            
        }else if cityTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile", body: "please Enter City")
            
        }
        else if stateTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile ", body: "Please Enter State")
            
        } else if aboutBusinessTextView.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Complete Profile ", body: "Please Enter about business")
            
        }
        else {
           
            
            let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant)
           
            let imageString = convertImageToBase64String(img: profileImage)
           
         //   print(imageString, "imageString...")
            
            
            let body :[String:Any] = [
                
                "userid": userID ?? "",
                "businessname": businessNameTextField.text!,
                "tinnumber": "715-304",
                "about": aboutBusinessTextView.text!,
                "address": businessAddressTextField.text!,
                "state": stateTextField.text!,
                "city": cityTextField.text!,
                "lat": "37.33",
                "lang": "77.77",
                "phone": "03035153574",
                "website": "www.jbl.com",
                "email": "muhammadusman17982@Gmail.com",
                
                "businesslogo":  imageString,
                
                "apikey": "shopie_AC4I_BD"
                
            ]
            
            completeProfileApi(param: body)
            
        }
    }
    
    //TODO :- API Calling
    private func completeProfileApi(param:[String:Any]) {
        self.spinneActivity.isHidden = false
        self.spinneActivity.startAnimating()
        Alamofire.request(merchantProfile1Url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
           self.spinneActivity.isHidden = true
           self.spinneActivity.stopAnimating()
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "SignUp", body: self.message)
                            
                            if self.message == "Merchant business setup 1;"{
                                let checkStoryBoard = UIStoryboard (name: "Marchant", bundle: nil)
                                let partner = checkStoryBoard.instantiateViewController(withIdentifier: "DeliverdMarVC") as! DeliverdMarVC
                                self.navigationController?.pushViewController(partner, animated: true)
                            }else if self.message == "Merchant business setup 2;"{
                                let checkStoryBoard = UIStoryboard (name: "Marchant", bundle: nil)
                                let partner = checkStoryBoard.instantiateViewController(withIdentifier: "DeliverdMarVC") as! DeliverdMarVC
                                self.navigationController?.pushViewController(partner, animated: true)
                            }else if self.message == "Merchant business setup"{
                                let checkStoryBoard = UIStoryboard (name: "Marchant", bundle: nil)
                                let partner = checkStoryBoard.instantiateViewController(withIdentifier: "DeliverdMarVC") as! DeliverdMarVC
                                self.navigationController?.pushViewController(partner, animated: true)
                            }
                           
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please Enter the right credential")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
    
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

//MARK:- UIImagePickerControllerDelegate
extension CompleteProfileMarVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
     {
         if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
             print("Button capture")
             
             imagePicker.delegate = self
             imagePicker.sourceType = .savedPhotosAlbum
             imagePicker.allowsEditing = false
             imagePicker.modalPresentationStyle = .fullScreen
             present(imagePicker, animated: true, completion: nil)
         }
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        uploadProfileImage.image = chosenImage
        profileImage = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
}
