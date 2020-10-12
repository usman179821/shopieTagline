//
//  detailOrderMCell.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 13/02/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class detailOrderMCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var priceFormulaLbl: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
