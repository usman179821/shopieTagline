//
//  AvailableGigsCell.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 27/01/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class AvailableGigsCell: UITableViewCell {

    @IBOutlet weak var electronicsImg: UIImageView!
    @IBOutlet weak var electronicsTitleNameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var milesAwayImg: UIImageView!
    @IBOutlet weak var mileawayNameLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UIImageView!
    @IBOutlet weak var pickNameLbl: UILabel!
    @IBOutlet weak var acceptDeliveryBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.borderColorGrey()
        acceptDeliveryBtn.RoundSpecificBottomCorner()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
