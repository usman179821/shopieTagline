//
//  HomeDriverVC.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 02/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class HomeDriverVC: UIViewController {

    @IBOutlet weak var acceptGigsTableView: UITableView!
    @IBOutlet weak var startEarnigView: UIView!
   
    
    //MARK:- properties and variables
//    var electronisImg : [UIImage] = [UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!,UIImage(named: "electronicsImg")!]
//    var electronicsTitleNameData = ["Electronics Express","Electronics Express","Electronics Express","Electronics Express","Electronics Express","Electronics Express","Electronics Express"]
//    var nameData = ["Merchant","Merchant","Merchant","Merchant","Merchant","Merchant","Merchant"]
//    var milawayImg : [UIImage] = [UIImage(named: "mileAway")!,UIImage(named: "mileAway")!,UIImage(named: "mileAway")!,UIImage(named: "mileAway")!,UIImage(named: "mileAway")!,UIImage(named: "mileAway")!,UIImage(named: "mileAway")!]
//    var milawayData = ["4.9 miles away","4.9 miles away","4.9 miles away","4.9 miles away","4.9 miles away","4.9 miles away","4.9 miles away"]
//    var pickupImage : [UIImage] = [UIImage(named: "pickUp")!,UIImage(named: "pickUp")!,UIImage(named: "pickUp")!,UIImage(named: "pickUp")!,UIImage(named: "pickUp")!,UIImage(named: "pickUp")!,UIImage(named: "pickUp")!]
//    var pickUpData =  ["pick Up from 9 West 46th Street","pick Up from 9 West 46th Street","pick Up from 9 West 46th Street","pick Up from 9 West 46th Street","pick Up from 9 West 46th Street","pick Up from 9 West 46th Street","pick Up from 9 West 46th Street"]
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Offline"
//        jobsCompletedView.shadowWithLessCornerRadius()
        startEarnigView.shadowWithLessCornerRadius()
//      navigationLeftIcon()
      navigationRightIcon()
        acceptGigsTableView.isHidden = true
        
    }
    
    @IBAction func StartEarningTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "acceptDeliveryDVC") as! acceptDeliveryDVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   
    
//    func navigationLeftIcon(){
//         let menuButton = UIBarButtonItem(image: UIImage(named: "leftTopNav")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftNavigation(sender:)))
//         self.navigationItem.leftBarButtonItem  = menuButton
//     }
     
//     @objc func leftNavigation(sender: UIBarButtonItem) {
//         // Function body goes here
////         self.waitingRequestView139.constant = 0
//        acceptGigsTableView.isHidden = false
//     }
    func navigationRightIcon(){
        let menuButton = UIBarButtonItem(image: UIImage(named: "notificationM")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(RightNavigation(sender:)))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func RightNavigation(sender: UIBarButtonItem) {
      
        showSwiftMessageWithParams(theme: .info, title: "Notification", body: "notification not implement yet from backend")
        
       
    }
    
//      //accept delivery
//      @objc func acceptDeliveryBtnTapped(sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "orderInformationDVC") as! orderInformationDVC
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//       }
   

}
//extension HomeDriverVC : UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return nameData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AvailableGigsCell
//        cell.electronicsImg.image = electronisImg[indexPath.row]
//        cell.electronicsTitleNameLbl.text = electronicsTitleNameData[indexPath.row]
//        cell.nameLbl.text = nameData[indexPath.row]
//        cell.milesAwayImg.image = milawayImg[indexPath.row]
//        cell.mileawayNameLbl.text = milawayData[indexPath.row]
//        cell.pickUpLbl.image = pickupImage[indexPath.row]
//        cell.pickNameLbl.text = pickUpData[indexPath.row]
//        cell.acceptDeliveryBtn.tag = indexPath.row
//        cell.acceptDeliveryBtn.addTarget(self, action: #selector(acceptDeliveryBtnTapped(sender:)), for: .touchUpInside)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//}

