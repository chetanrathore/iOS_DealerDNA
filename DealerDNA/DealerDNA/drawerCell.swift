//
//  drawerCell.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class drawerCell: UITableViewCell {

    @IBOutlet var lblMenuTitle: UILabel!
    @IBOutlet var imgMenuIcon: UIImageView!
    @IBOutlet var viewOuter: UIView!
    @IBOutlet var v1: UIView!
    @IBOutlet var v2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMenuTitle.font = appFont()
        viewOuter.layer.cornerRadius = viewOuter.bounds.width/2
        v1.backgroundColor = AppColor.selectedSideBarColor
        v2.backgroundColor = AppColor.selectedSideBarColor
        otherCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func selectedCell(){
        viewOuter.backgroundColor = AppColor.theamColor
        imgMenuIcon.setTintColor(color: UIColor.white)
        viewOuter.layer.borderWidth = 1
        viewOuter.layer.borderColor = AppColor.theamColor.cgColor
        lblMenuTitle.textColor  = UIColor.white
        self.contentView.backgroundColor = AppColor.selectedSideBarColor
    }
    
    func otherCell(){
        viewOuter.backgroundColor = AppColor.sideBarIconColor
        imgMenuIcon.setTintColor(color: UIColor.gray)
        viewOuter.layer.borderWidth = 1
        viewOuter.layer.borderColor = AppColor.selectedSideBarColor.cgColor
        lblMenuTitle.textColor  = UIColor.gray
        self.contentView.backgroundColor = AppColor.sideBarColor
    }
    
}
