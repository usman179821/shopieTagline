//
//  getProductMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 14/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class getProductMVC: UIViewController {
    
    //MARK:- outlets
    
    @IBOutlet weak var catgoryColVIew: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    
    //Variables and properties
    var catgoryArray = ["ELECTRONICS and multy ","FURNITURE","APPAREL","COSMETCS"]
    lazy var getProductDataArray = [getProductMerchantModel]()
    
    //MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func editBtnTapped(_sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddProductVC") as! AddProductVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addProductBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddProductVC") as! AddProductVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getProduct()
    }
    
    func getProduct(){
        let userId = UserDefaults.standard.string(forKey: SessionManager.Shared.userIDMarchant)
        let body :[String:Any] = [
            // "userid": userID ,
            "merchantid": userId ?? "",
            "apikey": "shopie_AC4I_BD"
        ]
        // print(body)
        getProductApi(param: body)
    }
    
    //MARK:- Api
    private func getProductApi(param:[String:Any]) {
        Alamofire.request(getProductMerchantUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                // print(response)
                self.getProductDataArray.removeAll()
                //   print(response.response?.statusCode)
                if response.result.error == nil {
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                
                                guard let data = jsonDic["data"]?.array else {return}
                                for item in data  {
                                    guard let dataDic = item.dictionary else {return}
                                    
                                    let productname = dataDic["productname"]?.string ?? ""
                                    let pricep = dataDic["price"]?.int ?? -1
                                    let stockp = dataDic["stock"]?.int ?? -1
                                    guard let imagesArray = dataDic["images"]?.array else {return}
                                    for img in imagesArray {
                                        guard let imageDic = img.dictionary else {return}
                                        let imageID = imageDic["imageid"]?.int ?? -1
                                        let imageUrl = imageDic["url"]?.string ?? ""
                                        
                                        
                                        let obj = getProductMerchantModel.init(productname: productname, price: pricep, stock: stockp, imageUrl: imageUrl,ImageID: imageID)
                                        self.getProductDataArray.append(obj)
                                        //    print(obj)
                                    }
                                    
                                }
                                
                                self.productTableView.reloadData()
                            }
                            
                        }catch let jsonErr{
                            // print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Get Product", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Get Product", body: "Something not working")
                    }
                } else {
                    //  print(response.result.error?.localizedDescription as Any)
                }
        }
    }
    
    
    
}
extension getProductMVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProductDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! getProductMCell
        let instance = getProductDataArray[indexPath.row]
        cell.productNameLbl.text = instance.productname
        cell.priceLbl.text = "\(instance.price!)"
        cell.stockLbl.text = "\(instance.stock!)"
        //cell.productImage.image = instance.imageUrl
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtnTapped(_sender:)), for: .touchUpInside)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


//MARK:- collection view
extension getProductMVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catgoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! getProductCollectionViewCell
        
        if indexPath.row == 0 {
            cell.colorLbl.isHidden = false
            cell.productCatgoryLbl.textColor = #colorLiteral(red: 0.9607843137, green: 0.3568627451, blue: 0.1176470588, alpha: 1)
        }else {
            cell.productCatgoryLbl.text = catgoryArray[indexPath.row]
            cell.colorLbl.isHidden = true
        }
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width // In this example the width is the same as the whole view.
        let height = CGFloat(50)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! getProductCollectionViewCell
        cell.productCatgoryLbl.textColor = #colorLiteral(red: 0.9607843137, green: 0.3568627451, blue: 0.1176470588, alpha: 1)
        cell.colorLbl.isHidden = false
        // print("USman")
        
        
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = CGSize(width: 200, height: 30)
    //                  return size
    //    }
}


