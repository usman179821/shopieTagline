//
//  AddProductVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddProductVC: UIViewController {
    
    //MARK:- outlets
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var sigleImageShow: UIImageView!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var productNameLbl: UITextView!
    @IBOutlet weak var catgoryLbl: UITextView!
    @IBOutlet weak var subCatgoryLbl: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLbl: UITextView!
    @IBOutlet weak var forSaleSwitchBtn: UISwitch!
    @IBOutlet weak var stockLbl: UITextView!
    @IBOutlet weak var addProdectBtn: UIButton!
    @IBOutlet weak var brandNameTextView: UITextView!
    
    //MARK:- Variables and variables
    var message = ""
    var selectedImagesArray = [UIImage]()
    var imagePicker = UIImagePickerController()
    private var currentImageViewForImagePicking: UIImageView? = nil
    
    //MARK:- View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Product"
        addProdectBtn.shadow()
        spinner.isHidden = true
        sigleImageShow.layer.cornerRadius = 8
        
//        self.addImageBtn.addTarget(self, action: #selector(showImageBtn(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
//    @objc private func showImageBtn (_ sender: UIButton){
//        if selectedImagesArray.count >= 14 {
//            showSwiftMessageWithParams(theme: .error, title: "Error", body: "You can add max 14 images.")
//        }else {
//
//            toggleAddPhotosView(flag: true)
//
//        }
//
//    }
    
//    private func toggleAddPhotosView(flag: Bool){
//
//        if flag {
//
//            // addMorePhotosPopUpView.isHidden = false
//            //   dimView.isHidden = false
//
//        }else {
//
//            //  addMorePhotosPopUpView.isHidden = true
//            // dimView.isHidden = true
//
//        }
//
//    }
    
    //Actions
    
    @IBAction func addImageBtnTapped(_ sender: Any) {
        
        currentImageViewForImagePicking = sigleImageShow
              imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
              imagePicker.delegate = self
              present(imagePicker, animated: true)
        
    }
    @IBAction func addProductTapped(_ sender: Any) {
        if productNameLbl.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Add Product", body: "Please Enter Product Name ")
            
        }
        else if catgoryLbl.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Add Product", body: "please Enter Product Catgory")
            
        }else if subCatgoryLbl.text!.isEmpty {
            showSwiftMessageWithParams(theme: .info, title: "Add Product", body: "please Enter Product Subcatgory")
            
        }
        else if descriptionTextView.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Add Product ", body: "Please Enter Product Description")
            
        }else if priceLbl.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Add Product ", body: "Please Enter Product Price")
            
        }
        else if stockLbl.text!.isEmpty{
            showSwiftMessageWithParams(theme: .info, title: "Add Product ", body: "Please Enter Stoke")
            
        }
        else {
             let imageString = convertImageToBase64String(img: sigleImageShow?.image ?? UIImage())
            let userId = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant)
            let body :[String:Any] = [
                "userid": userId ?? "",
                "product_title": productNameLbl.text!,
                "brand": "Usman",
                "productdescription": descriptionTextView.text!,
                "category": catgoryLbl.text!,
                "subcategory": subCatgoryLbl.text!,
                "onsale": "0",
                "stock": stockLbl.text!,
                "price": priceLbl.text!,
               
                "images": [imageString],
                // “Images”: [“base 64 image1”, “base 64 image 2”, “3”, “4”]
                "apikey": "shopie_AC4I_BD"
                
            ]
            addproductApi(param: body)
            
        }
    }
    
    //TODO :- API Calling
    private func addproductApi(param:[String:Any]) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        Alamofire.request(addProductUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseString{ (response) in
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
           // print(response)
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            if response.result.error == nil {
                if response.response?.statusCode == 200 {
                    guard let data = response.data else {return}
                    
                    do{
                        
                        if let jsonDic = try JSON (data: data).dictionary {
                            self.message = jsonDic["message"]?.string ?? ""
                            showSwiftMessageWithParams(theme: .info, title: "Add Product", body: self.message)
                            print(self.message)
                            if self.message == "Product added successfully"{
//                                let SB = UIStoryboard(name: "Merchant", bundle: nil)
//                                let vc = SB.instantiateViewController(identifier: "getProductMVC") as! getProductMVC
//                                self.
                                self.navigationController?.popViewController(animated: true)
                            }
                            
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                        
                        showSwiftMessageWithParams(theme: .info, title: "SignUp", body: jsonErr.localizedDescription)
                    }
                    
                }else {
                   // showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Please Enter the right credential")
                }
            } else {
            //    print(response.result.error?.localizedDescription as Any)
            }
        }
    }
}


//MARK: Image Picker Extensions
extension AddProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        currentImageViewForImagePicking?.image  = tempImage
        if currentImageViewForImagePicking == sigleImageShow{
            //profileImageBGView.isHidden = true
            sigleImageShow.layer.cornerRadius = 8
            sigleImageShow.layer.masksToBounds = true
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
    //convert Image base64 encode or decode
    func convertImageToBase64String (img: UIImage) -> String {

        return img.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
      }
      //Decoding
      
      func convertBase64StringToImage (imageBase64String:String) -> UIImage {
          let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
          let image = UIImage(data: imageData!)
          return image!
      }

}
//MARK: UICollectionView Extension
//extension AddProductVC : UICollectionViewDelegate, UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return selectedImagesArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedAssetsCollectionViewCell", for: indexPath) as! SelectedAssetsCollectionViewCell
//        cell.selectedAssetImageView.image = self.selectedImagesArray[indexPath.row]
//
//        return cell
//
//    }
//
//}

