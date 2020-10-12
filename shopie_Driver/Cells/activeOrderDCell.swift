//
//  activeOrderDCell.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 20/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class activeOrderDCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
    @IBOutlet weak var storeNameLbl
    : UILabel!
    @IBOutlet weak var itemsLbl: UILabel!
    @IBOutlet weak var cancelBtnTapped: UIButton!
    @IBOutlet weak var viewDetailTapped: UIButton!
    @IBOutlet weak var cardeView: UIView!
    @IBOutlet weak var viewCompleteBtnTapped: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cardeView.borderColorGrey8()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
