//
//  SettingsCell.swift
//  DealerDNA
//
//  Created by LaNet on 4/10/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgIcon.setTintColor(color: UIColor.gray)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
