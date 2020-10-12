//
//  payHistoryDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 10/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class payHistoryDVC: UIViewController {

    
    @IBOutlet weak var payHistoryTableView: UITableView!
    
    //MARK:- variables and properties
    var depositeNameDataArray = ["Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123",]
    var timeAndDateDataArray = ["30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am","30 Jun 2018, 11:59 am",]
    var priceDataArray = ["$ 5.20 ","$ 5.20 ","$ 5.20 ","$ 5.20 ","$ 5.20 ","$ 5.20 ","$ 5.20 ","$ 5.20 ",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pay History"

        // Do any additional setup after loading the view.
    }
    

    

}
extension payHistoryDVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! payHistoryDCell
        cell.depositeNameLbl.text = depositeNameDataArray[indexPath.row]
        cell.dateAndTimeLbl.text = timeAndDateDataArray[indexPath.row]
        cell.priceLbl.text = priceDataArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
