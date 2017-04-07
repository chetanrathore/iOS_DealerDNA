//
//  DashboardCollectionCell.swift
//  DealerDNA
//
//  Created by LaNet on 4/5/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class DashboardCollectionCell: UICollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = appFont(size: AppFont.normalFontSize, fontWeight: .kSemiBold)
        lblCount.font = appFont(size: (Screen.device == .pad) ? 55 : 30, fontWeight: .kBold)
    }

}
