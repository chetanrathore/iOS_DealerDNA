//
//  DashboardConstant.swift
//  DealerDNA
//
//  Created by LaNet on 3/30/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

struct DashBoardMenu {
    
    static let home = "Home"
    static let dashboard = "Dashboard"
    static let inventory = "Inventory"
    static let dlScan = "DLScan"
    static let customer = "Customers"
    static let setting = "Settings"
    static let logout = "Log Out"
    
    static let homeTilesIcon = "Home"
    static let dashboardTilesIcon = "Dashboard"
    static let inventoryTilesIcon = "Inventory"
    static let dlScanTilesIcon = "DLScan"
    static let customerTilesIcon = "Customers"
    static let settingTilesIcon = "Settings"
    static let logoutTilesIcon = "LogOut"
    
    static let dashboardTilesColor = hexStringToUIColor(hex: "CD1C00")
    static let homeTilesColor = hexStringToUIColor(hex: "CD1C00")
    static let inventoryTilesColor = hexStringToUIColor(hex: "EE6C1C")
    static let dlScanTilesColor = hexStringToUIColor(hex: "5DB000")
    static let customerTilesColor = hexStringToUIColor(hex: "35b7e3")
    static let settingTilesColor = hexStringToUIColor(hex: "125469")
    static let logoutTilesColor = hexStringToUIColor(hex: "CD1C00")
}

class Dasdhboard{
    var mainTitle: String = ""
    var subSection = [DashboadMster]()
    init(mainTitle: String, subSection: [DashboadMster]) {
        self.mainTitle = mainTitle
        self.subSection = subSection
    }
}

class DashboadMster{
    var title: String = ""
    var count: Int = 0
    var backColor = UIColor.red
    
    init(title: String, count: Int, backColor: UIColor) {
        self.title = title
        self.count = count
        self.backColor = backColor
    }
    
}
