//
//  orderDetailCompleteMVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 14/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class orderDetailCompleteMVC: UIViewController {
    
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var orderIDLbl: UILabel!
    @IBOutlet weak var refundCustomerBtn: UIButton!
    
    
    

    //MARK:- variables and properties
    var nameProductArray = ["Apple Smart keyboared for iPAD (7th Generation) and","Apple Smart keyboared for iPAD (7th Generation) and"]
    var priceArray = ["$200.00","$300.00"]
    var priceFormulArray = ["1* -200","2* - 200"]
    var dataArray = [orderActiveModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refundCustomerBtn.shadow()
        settingTableView()
       // self.orderTableView.rowHeight = UITableView.automaticDimension
        setupViewCompleteApi()
        
    }
    
    func  setupViewCompleteApi(){
        dateAndTimeLbl.text = dataArray[0].orderPlacedDate
        orderIDLbl.text = "Order ID #" + "\(dataArray[0].orderID!)"
        customerNameLbl.text = dataArray[0].customerName
        
    }
    
    
    //Auto increase table view height depend on cell
    func settingTableView(){
        orderTableView.reloadData()
              orderTableView.layoutIfNeeded()
              self.orderTableView.estimatedRowHeight = 100
    }
    
    override func viewDidLayoutSubviews() {
        orderTableView.heightAnchor.constraint(equalToConstant: orderTableView.contentSize.height).isActive = true
    }
    
   
    
}
extension orderDetailCompleteMVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! detailOrderMCell
        let instance = dataArray[indexPath.row]
        cell.nameLbl.text = instance.productName
        cell.priceLbl.text = "\(instance.totalcost!)"
      //  cell.priceFormulaLbl.text = priceFormulArray[indexPath.row]
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

