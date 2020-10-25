//
//  productCatgoryMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 29/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class productCatgoryMVC: UIViewController {
    
    
    @IBOutlet weak var categoryTableview: UITableView!
    
    lazy var categoryArray = [categoryModel]()
    lazy var currentArray = [categoryModel]()
    var catDic = [String: String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category()
        
        // Do any additional setup after loading the view.
    }
    
    func category(){
        
        let body :[String:Any] = [
            // "userid": userID ,
            "apikey":"shopie_AC4I_BD",
            
        ]
        // print(body)
        categoryApi(param: body)
        
    }
    //MARK:- Api
    private func categoryApi(param:[String:Any]) {
        AF.request(productCategoryDataUrl, method: .post, parameters: param, encoding:
            JSONEncoding.default, headers: nil).responseJSON { (response) in
                //  print(response)
                //   print(response.response?.statusCode)
                
                    if response.response?.statusCode == 200 {
                        guard let data = response.data else {return}
                        
                        do{
                            
                            if let jsonDic = try JSON (data: data).dictionary {
                                
                                guard let data = jsonDic["data"]?.array else {return}
                                for item in data  {
                                    guard let dataDic = item.dictionary else {return}
                                    let categoryId = dataDic["categoryid"]?.string ?? ""
                                    let parentId = dataDic["parent"]?.string ?? ""
                                    let name = dataDic["name"]?.string ?? ""
                                    
                                    //                                    "hasgender": "0",
                                    //                                    "hasnewold": "0",
                                    //                                    "url": "product\/catimages\/electronics.png",
                                    //                                    "gender": ""
                                    let object = categoryModel.init(parentID: parentId, categoryID: categoryId, name: name)
                                    
                                    self.categoryArray.append(object)
                                    
                                    if object.parentID == "" {
                                        self.currentArray.append(object)
                                    }
                                    
                                    
                                }
                                //  print(self.currentArray,"current array data")
                                self.categoryTableview.reloadData()
                            }
                            
                        }catch let jsonErr{
                            // print(jsonErr)
                            
                            showSwiftMessageWithParams(theme: .info, title: "Product", body: jsonErr.localizedDescription)
                        }
                        
                    }else {
                        showSwiftMessageWithParams(theme: .error, title: "Product", body: "Something not working")
                    }
               
        }
    }
    private func getSubCatgory (id: String) {
        var tempArray = [categoryModel]()
        for item in categoryArray {
            
            if item.parentID == id {
                tempArray.append(item)
            }
        }
        if tempArray.isEmpty {
            catDic["subcategory"] = id
            print("show the subCatGory",catDic)
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is AddProductVC {
                    let vc = aViewController as! AddProductVC
                    vc.catIdDic = catDic
                    self.navigationController!.popToViewController(vc, animated: true)
                }
            }
            //  self.navigationController?.popViewController(animated: true)
        }else {
            
            currentArray = tempArray
            self.categoryTableview.reloadData()
        }
        
    }
}
extension productCatgoryMVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! productCategoryMCell
        cell.categoryLbl.text = currentArray[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let catID = currentArray[indexPath.row].categoryID else {return}
        if currentArray[indexPath.row].parentID == nil ||  currentArray[indexPath.row].parentID == "" {
            catDic["category"] = catID
        }
        
        getSubCatgory(id: catID)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
extension  UIButton{
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        layer.add(flash, forKey: nil)
    }
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.15
        animation.values = [ 200.0, -50.0, 100.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
}
