//
//  EarningDVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class EarningDVC: UIViewController {

    //MARK:- outltes
    
  
    
    //MARK:- variables and peroties
    var depositeData = ["Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123","Deposite # 123"]
    var dateAndTimeData = ["30 jun 2018 , 11:34 am ","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am","30 jun 2018 , 11:34 am"]
    var priceData = ["$5.20","$5.20","$5.20","$5.20","$5.20","$5.20","$5.20","$5.20","$5.20"]
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Your Earnings"
      
       
        
        // Do any additional setup after loading the view.
    }
    

 

}
extension EarningDVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! earningTableCells
        cell.depositNoLbl.text = depositeData[indexPath.row]
        cell.dateAndTimeLbl.text = dateAndTimeData[indexPath.row]
        cell.priceLbl.text = priceData[indexPath.row]
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

