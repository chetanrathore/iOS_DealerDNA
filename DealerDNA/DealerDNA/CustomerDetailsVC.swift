//
//  CustomerDetailsVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class CustomerDetailsVC: UIViewController, CustomNevigationDeletegate {
    
    let customNav = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        customNav.createView(self.view, title: "Customer Detail", backBtn: .back, rightBtnTitle: nil, rightButtonImage: nil)
        customNav.delegate = self
    }
    
    func btnLeftClick() {
        let vc = DrawerVC(nibName: "DrawerVC", bundle: nil)
        revealSideViewController.push(vc, on: .left, animated: true)
    }

}
