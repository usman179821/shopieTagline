//
//  activeOrderDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 20/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class activeOrderDVC: UIViewController {
    
    //MARK:- outltes
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var completeTableView: UITableView!
    
    //MARK:- variables and properties
    var dateAndTimeDataArray = ["Thu,25 jun 2020","Thu,25 jun 2020","Thu,25 jun 2020","Thu,25 jun 2020","Thu,25 jun 2020","Thu,25 jun 2020",]
    var priceDataArray = ["$ 000.00","$ 000.00","$ 000.00","$ 000.00","$ 000.00","$ 000.00",]
    var orderNumberArray = ["1234567","1234567","1234567","1234567","1234567","1234567",]
    var orderTitleNameArray = ["Apple Keyboared (1) Mac Charger (1), Airpod (2)","Apple Keyboared (1) Mac Charger (1), Airpod (2)","Apple Keyboared (1) Mac Charger (1), Airpod (2)","Apple Keyboared (1) Mac Charger (1), Airpod (2)","Apple Keyboared (1) Mac Charger (1), Airpod (2)","Apple Keyboared (1) Mac Charger (1), Airpod (2)",]
    var message = ""
    lazy var getActiveOrderArray = [orderActiveModel]()
     lazy var completeOrderArray = [orderActiveModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Orders"
        self.completeTableView.isHidden = true
        segmentCustomise()
        activeOrder()
        completeOrcancelorder()
        
    }
    
    
    func activeOrder(){
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
        let body :[String:Any] = [
           // "userid": userID ,
            "userid": userID ?? "",
           
            "apikey":"shopie_AC4I_BD",
            
        ]
        
        print(body)
        activeOrderAPI(param: body)

    }
    
    func completeOrcancelorder(){
        let userID = UserDefaults.standard.string(forKey: SessionManager.Shared.userIdDriver)
        let body :[String:Any] = [
           // "userid": userID ,
            "userid": userID ?? "",
           
            "apikey":"shopie_AC4I_BD",
            
        ]
        
        completOrder(param: body)

    }
    

            //MARK:- Api
            private func completOrder(param:[String:Any]) {
                Alamofire.request(completeOrCancelOrderDUrl, method: .post, parameters: param, encoding:
                    JSONEncoding.default, headers: nil).responseJSON { (response) in
                        print(response)
                        //   print(response.response?.statusCode)
                        if response.result.error == nil {
                            if response.response?.statusCode == 200 {
                                guard let data = response.data else {return}
                                
                                do{
                                    
                                    if let jsonDic = try JSON (data: data).dictionary {
                                        
                                        guard let data = jsonDic["data"]?.array else {return}
                                        for item in data  {
                                            guard let dataDic = item.dictionary else {return}
                                            let orderID = dataDic["orderid"]?.string ?? ""
                                            let customerid = dataDic["customerid"]?.string ?? ""
                                            let merchantid = dataDic["merchantid"]?.string ?? ""
                                            let driverid = dataDic["driverid"]?.string ?? ""
                                            let orderplaceddate = dataDic["orderplaceddate"]?.string ?? ""
                                            //.........
                                            guard let productArray = dataDic["products"]?.array else {return}
                                            for  item2 in productArray {
                                                guard let ProductDic = item2.dictionary else {return}
                                                let productid = ProductDic["productid"]?.string ?? ""
                                                let productName = ProductDic["productname"]?.string ?? ""
                                                let productctQuantity = ProductDic["quantity"]?.int ?? -1
                                                ///....
                                                let totalcost = dataDic["totalcost"]?.double ?? 0.00
                                                guard let merchantDic = dataDic["merchant"]?.dictionary else {return}
                                                
                                                //.....
                                                guard let businessDic = merchantDic["business"]?.dictionary else {return}
                                                
                                                let businessname = businessDic["businessname"]?.string ?? ""
                                                //                                            "userid": "5f649cbf84cfc",
                                                //                                                           "name": "Muhammad Naeem",
                                                //                                                           "username": "",
                                                
                                                guard let customerDic = dataDic["customer"]?.dictionary else {return}
                                                
                                                //..............
                                                
                                                let object = orderActiveModel.init(orderID: orderID, customerID: customerid, merchantID: merchantid, driverID: driverid, productID: productid, productName: productName, ProductQuantity: productctQuantity, orderPlacedDate: orderplaceddate, bussinessName: businessname,totalcost: totalcost)
                                                self.completeOrderArray.append(object)
                                                
                                                
                                                
                                            }
                                            
                                            //                                        let object = orderActiveModel.init(orderPlacedDate: orderplaceddate)
                                            //                                        self.getActiveOrderArray.append(object)
                                            
                                        }
                                        
                                        self.completeTableView.reloadData()
                                    }
                                    
                                }catch let jsonErr{
                                    print(jsonErr)
                                    
                                    showSwiftMessageWithParams(theme: .info, title: "Active Orders", body: jsonErr.localizedDescription)
                                }
                                
                            }else {
                                showSwiftMessageWithParams(theme: .error, title: "Active Orders", body: "Something is not working")
                            }
                        } else {
                            print(response.result.error?.localizedDescription as Any)
                        }
                }
            }
    
        //MARK:- Api
        private func activeOrderAPI(param:[String:Any]) {
            Alamofire.request(activeOrderDUrl, method: .post, parameters: param, encoding:
                JSONEncoding.default, headers: nil).responseJSON { (response) in
                    print(response)
                    //   print(response.response?.statusCode)
                    if response.result.error == nil {
                        if response.response?.statusCode == 200 {
                            guard let data = response.data else {return}
                            
                            do{
                                
                                if let jsonDic = try JSON (data: data).dictionary {
                                    
                                    guard let data = jsonDic["data"]?.array else {return}
                                    for item in data  {
                                        guard let dataDic = item.dictionary else {return}
                                        let orderID = dataDic["orderid"]?.string ?? ""
                                        let customerid = dataDic["customerid"]?.string ?? ""
                                        let merchantid = dataDic["merchantid"]?.string ?? ""
                                        let driverid = dataDic["driverid"]?.string ?? ""
                                        let orderplaceddate = dataDic["orderplaceddate"]?.string ?? ""
                                        //.........
                                        guard let productArray = dataDic["products"]?.array else {return}
                                        for  item2 in productArray {
                                            guard let ProductDic = item2.dictionary else {return}
                                            let productid = ProductDic["productid"]?.string ?? ""
                                            let productName = ProductDic["productname"]?.string ?? ""
                                            let productctQuantity = ProductDic["quantity"]?.int ?? -1
                                            ///....
                                              let totalcost = dataDic["totalcost"]?.double ?? 0.00
                                            guard let merchantDic = dataDic["merchant"]?.dictionary else {return}
                                            
                                            //.....
                                            guard let businessDic = merchantDic["business"]?.dictionary else {return}
                                            
                                            let businessname = businessDic["businessname"]?.string ?? ""
                                            //                                            "userid": "5f649cbf84cfc",
                                            //                                                           "name": "Muhammad Naeem",
                                            //                                                           "username": "",
                                            
                                            guard let customerDic = dataDic["customer"]?.dictionary else {return}
                                            
                                            //..............
                                            
                                            let object = orderActiveModel.init(orderID: orderID, customerID: customerid, merchantID: merchantid, driverID: driverid, productID: productid, productName: productName, ProductQuantity: productctQuantity, orderPlacedDate: orderplaceddate, bussinessName: businessname,totalcost: totalcost)
                                            print(object)
                                            self.getActiveOrderArray.append(object)
//                                            let SB = UIStoryboard(name: "Main", bundle: nil)
//                                            let vc = SB.instantiateViewController(identifier: "startDeliveryDVC") as!  startDeliveryDVC
                                           // vc.passigData = self.getActiveOrderArray
                                            //self.navigationController?.pushViewController(vc, animated: true)
                                           
                                            }
                                            
                                            
                                        }
                                        
                                        //                                        let object = orderActiveModel.init(orderPlacedDate: orderplaceddate)
                                        //                                        self.getActiveOrderArray.append(object)
                                        
                                    }
                                if self.getActiveOrderArray.count == 0 {
                                    showSwiftMessageWithParams(theme: .info, title: "Order Information", body: "Order List Not Obtained")
                                    self.orderTableView.reloadData()
                                }
                                
                            }catch let jsonErr{
                                print(jsonErr)
                                
                                showSwiftMessageWithParams(theme: .info, title: "Orders", body: jsonErr.localizedDescription)
                            }
                            
                        }else {
                            showSwiftMessageWithParams(theme: .error, title: "Orders", body: "Something is not working")
                        }
                    } else {
                        print(response.result.error?.localizedDescription as Any)
                    }
            }
        }
    
    func segmentCustomise(){
    
    segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
    }
    @IBAction func segmentControlTapped(_ sender: Any) {
        
        let getIndex = segmentControll.selectedSegmentIndex
        print(getIndex)
        switch getIndex {
        case 0:
            self.orderTableView.isHidden = false
            self.completeTableView.isHidden = true
        case 1 :
            self.orderTableView.isHidden = true
            self.completeTableView.isHidden = false
        default:
            print("No Index")
        }
    }
    
    @objc func cancelOrderBtnTapped(_sender: UIButton) {
        print("Cancel Order")
        
    }
    @objc func viewOrderDetailBtnTapped(_sender: UIButton){
        
//        let vc = storyboard?.instantiateViewController(identifier: "detailOrderMVC") as! detailOrderMVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func viewCompleteOrderTapped(_sender: UIButton) {
        print("Complete Order")
        
//        let vc = storyboard?.instantiateViewController(identifier: "orderDetailCompleteMVC") as! orderDetailCompleteMVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
}
extension activeOrderDVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == orderTableView {
        return dateAndTimeDataArray.count
        }else {
            return dateAndTimeDataArray.count
        }
    }
//    {
//        if tableView == orderTableView {
//        return getActiveOrderArray.count
//        }else {
//            return completeOrderArray.count
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! activeOrderDCell
            
            if tableView == self.orderTableView {
                cell.dateAndTimeLbl.text = dateAndTimeDataArray[indexPath.row]
                cell.storeNameLbl.text = orderTitleNameArray[indexPath.row]
                cell.priceLbl.text = priceDataArray[indexPath.row]
    //        cell.priceLbl.text = priceDataArray[indexPath.row]
    //        cell.storeNameLbl.text = orderTitleNameArray[indexPath.row]
    //        cell.orderNumberLbl.text = orderNumberArray[indexPath.row]
            cell.cancelBtnTapped.tag = indexPath.row
           // cell.cancelBtnTapped.addTarget(self, action: #selector(cancelOrderBtnTapped(_sender:)), for: .touchUpInside)
           // cell.viewDetailTapped.addTarget(self, action: #selector(viewOrderDetailBtnTapped(_sender:)), for: .touchUpInside)
            cell.viewDetailTapped.RoundSpecificBottomCornerR()
            cell.cancelBtnTapped.RoundSpecificBottomCornerL()
            }else {
              //  let instance = completeOrderArray[indexPath.row]
                cell.dateAndTimeLbl.text = dateAndTimeDataArray[indexPath.row]
                cell.priceLbl.text = priceDataArray[indexPath.row]
                cell.storeNameLbl.text = orderTitleNameArray[indexPath.row]
               // cell.orderNumberLbl.text = instance.orderID
               
               // cell.viewDetailTapped.addTarget(self, action: #selector(viewCompleteOrderTapped(_sender:)), for: .touchUpInside)
                cell.viewDetailTapped.RoundSpecificBottomCornerLR()
                
                
              
            }
            
            
            
            
            
            return cell
            
        }
//    {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! activeOrderDCell
//
//        if tableView == self.orderTableView {
//            cell.dateAndTimeLbl.text = getActiveOrderArray[indexPath.row].orderPlacedDate
//            cell.storeNameLbl.text = getActiveOrderArray[indexPath.row].bussinessName
//            cell.priceLbl.text = "\(getActiveOrderArray[indexPath.row].totalcost!)"
////        cell.priceLbl.text = priceDataArray[indexPath.row]
////        cell.storeNameLbl.text = orderTitleNameArray[indexPath.row]
////        cell.orderNumberLbl.text = orderNumberArray[indexPath.row]
//        cell.cancelBtnTapped.tag = indexPath.row
//       // cell.cancelBtnTapped.addTarget(self, action: #selector(cancelOrderBtnTapped(_sender:)), for: .touchUpInside)
//       // cell.viewDetailTapped.addTarget(self, action: #selector(viewOrderDetailBtnTapped(_sender:)), for: .touchUpInside)
//        cell.viewDetailTapped.RoundSpecificBottomCornerR()
//        cell.cancelBtnTapped.RoundSpecificBottomCornerL()
//        }else {
//            let instance = completeOrderArray[indexPath.row]
//            cell.dateAndTimeLbl.text = instance.orderPlacedDate
//            cell.priceLbl.text = "\(instance.totalcost!)"
//            cell.storeNameLbl.text = instance.bussinessName
//            cell.orderNumberLbl.text = instance.orderID
//
//           // cell.viewDetailTapped.addTarget(self, action: #selector(viewCompleteOrderTapped(_sender:)), for: .touchUpInside)
//            cell.viewDetailTapped.RoundSpecificBottomCornerLR()
//
//
//
//        }
//
//
//
//
//
//        return cell
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
}

