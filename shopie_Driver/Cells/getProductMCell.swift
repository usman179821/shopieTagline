//
//  getProductMCell.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 14/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class getProductMCell: UITableViewCell {

    //MARK:- outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
