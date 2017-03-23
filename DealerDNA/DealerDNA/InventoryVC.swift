//
//  InventoryVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryVC: UIViewController {
    
    @IBOutlet var btnMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        getInventory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleBtnMenu(_ sender: UIButton) {
        let vc = DrawerVC(nibName: "DrawerVC", bundle: nil)
        revealSideViewController.push(vc, on: .left, animated: true)
    }
    
    
    
    // MARK: - Navigation
    
    func getInventory() {
        let manager = AFHTTPSessionManager()
        manager.get("https://jsonplaceholder.typicode.com/users", parameters: [:], progress: { (progress) in
            print("In process")
        }, success: { (task, response) in
            print(response ?? "Not found")
        }) { (task, error) in
            print("Error")
            print(error)
        }
    }
    
}
