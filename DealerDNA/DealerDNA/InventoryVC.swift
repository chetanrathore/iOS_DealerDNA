//
//  InventoryVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomNevigationDeletegate {
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var segmentFilter: UISegmentedControl!
    @IBOutlet var tblInventory: UITableView!
    @IBOutlet var vwTop: UIView!
    @IBOutlet var lblTitle: UILabel!
    let customNav = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblInventory.register(UINib(nibName: "InventoryListCell", bundle: nil), forCellReuseIdentifier: "InventoryListCell")
        tblInventory.dataSource = self
        tblInventory.delegate = self
        customNav.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       // getInventory()
    }
    
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout(){
        self.navigationController?.navigationBar.isHidden = true
        tblInventory.estimatedRowHeight = 100
        tblInventory.rowHeight = UITableViewAutomaticDimension
        segmentFilter.tintColor = AppColor.theamColor
        customNav.createView(self.view, title: "Inventory", backBtn: .menu, isRightRequired: true, rightBtnTitle: "Add", rightButtonImage: nil)
        
    }
    
    func btnLeftClick() {
        let vc = DrawerVC(nibName: "DrawerVC", bundle: nil)
        revealSideViewController.push(vc, on: .left, animated: true)
    }
    
    func btnRightClick() {
        let addVC = AddInventoryVC(nibName: "AddInventoryVC", bundle: nil)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    // MARK: Table methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // customNav.createView(self.view)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryListCell", for: indexPath) as! InventoryListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = InventoryDetailVC(nibName: "InventoryDetailVC", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      //  NotificationCenter.default.post(name: Notification.Name(rawValue: "OrientationWillChange"), object: nil)
    }
    
}
