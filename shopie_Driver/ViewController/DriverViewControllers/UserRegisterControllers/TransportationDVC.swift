//
//  TransportationDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class TransportationDVC: UIViewController {
    
    //MARK:- outlets
    
    @IBOutlet weak var vehiclePictureImg: UIImageView!
    @IBOutlet weak var vehicleTypeTextField: HoshiTextField!
    @IBOutlet weak var carMakeTextField: HoshiTextField!
    @IBOutlet weak var carModelTextField: HoshiTextField!
    @IBOutlet weak var yearTextField: HoshiTextField!
    @IBOutlet weak var colorTextField: HoshiTextField!
    @IBOutlet weak var getStartedBtn: UIButton!
    
    //MARK:- Variables
    var message = ""
    var profileImage = UIImage()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedBtn.shadow()
        imageSetUp()
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
              vehiclePictureImg.isUserInteractionEnabled = true
              vehiclePictureImg.addGestureRecognizer(tapGestureRecognizer)
    }
    func imageSetUp() {
        vehiclePictureImg.layer.cornerRadius = 6
        vehiclePictureImg.layer.masksToBounds = true
        vehiclePictureImg.layer.borderColor = #colorLiteral(red: 0.6394010186, green: 0.6394163966, blue: 0.6394081116, alpha: 1)
        vehiclePictureImg.layer.borderWidth = 1
        
    }
    
    @IBAction func getStartedBtnTapped(_ sender: Any) {
        if vehicleTypeTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: "Please Enter Vehicle Type ")
            
        }
        else if carMakeTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: "please Enter your Car Make ")
            
        }else if carModelTextField.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: "please Enter your car model")
            
        }
        else if yearTextField.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Transport Detail ", body: "Please Enter year")
            
        }else if  colorTextField.text!.isEmpty  {
            showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: "Please Enter car color")
        }
        else {
            //Image convert base 64
//            let imageData = profileImage.pngData()?.base64EncodedString()
//            print(imageData ?? "")
            
            let userid = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
            
            let body :[String:Any] = [
                
                "userid": userid ?? "",
                "transport": vehicleTypeTextField.text!,
                "make": carMakeTextField.text!,
                "model": carModelTextField.text!,
                "year": yearTextField.text!,
                "color": colorTextField.text!,
                
                "apikey": "shopie_AC4I_BD"
                
            ]
            
            print(body)
            driverTransportDetaileApi(param: body)
            
        }
    }
    
    
    //TODO :- API Calling
    private func driverTransportDetaileApi(param:[String:Any]) {
        Alamofire.request(driverTransportUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: self.message)
//                            let checkStoryBoard = UIStoryboard (name: "Main", bundle: nil)
                            if self.message == "User transport details added successfully" {
                                let partner = self.storyboard?.instantiateViewController(withIdentifier: "CompleteProfileDVC") as! CompleteProfileDVC
                                self.navigationController?.pushViewController(partner, animated: true)
                            }else {
                                
                            }
                            
                            
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "Transport Detail", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                    showSwiftMessageWithParams(theme: .error, title: "Transport Detail", body: "Please Enter the right credential")
                }
            } else {
                print(response.result.error?.localizedDescription as Any)
            }
        }
    }
    
    
    //Convert base 64 image formate
//    func convertImageToBase64String (img: UIImage) -> String {
//        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
//    }
    //Decoding
    
//    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
//        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
//        let image = UIImage(data: imageData!)
//        return image!
//    }
}


//MARK:- UIImagePickerControllerDelegate
extension TransportationDVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
        vehiclePictureImg.image = chosenImage
        profileImage = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
}
