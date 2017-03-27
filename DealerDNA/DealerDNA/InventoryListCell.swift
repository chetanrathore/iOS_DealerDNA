//
//  InventoryListCell.swift
//  DealerDNA
//
//  Created by LaNet on 3/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryListCell: UITableViewCell {

    
    @IBOutlet var imgInventory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgInventory.layer.cornerRadius = 5
        imgInventory.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
