//
//  earningTableCells.swift
//  shopie_Driver
//
//  Created by Muhammad Usman on 26/01/1442 AH.
//  Copyright © 1442 Macbook. All rights reserved.
//

import UIKit

class earningTableCells: UITableViewCell {

    @IBOutlet weak var depositNoLbl: UILabel!
      @IBOutlet weak var dateAndTimeLbl: UILabel!
      @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
