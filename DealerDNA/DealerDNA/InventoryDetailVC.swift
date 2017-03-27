//
//  InventoryDetailVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryDetailVC: UIViewController, CustomNevigationDeletegate {

    let customNav = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
    
    func setLayout(){
        customNav.delegate = self
        customNav.createView(self.view, title: "Inventory detail", backBtn: .back, isRightRequired: false, rightBtnTitle: nil, rightButtonImage: nil)
    }
    
    func btnLeftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
