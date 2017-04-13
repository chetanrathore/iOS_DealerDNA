//
//  User.swift
//  DealerDNA
//
//  Created by LaNet on 4/10/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

class AppData: NSObject, NSCoding{
    
    var dashBoardTiles = NSArray()
    var sideMenuItem = NSArray()
    
    init(dashBoardTiles: NSArray, sideMenuItem: NSArray){
        self.dashBoardTiles = dashBoardTiles
        self.sideMenuItem = sideMenuItem
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let dashBoardTiles = aDecoder.decodeObject(forKey: "dashBoardTiles") as! NSArray
        let sideMenuItem = aDecoder.decodeObject(forKey: "sideMenuItem") as! NSArray
        self.init(
            dashBoardTiles: dashBoardTiles,
            sideMenuItem: sideMenuItem
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dashBoardTiles, forKey: "dashBoardTiles")
        aCoder.encode(sideMenuItem, forKey: "sideMenuItem")
    }
}
