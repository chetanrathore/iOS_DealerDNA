//
//  DrawerVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class DrawerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var vwProfile: UIView!
    @IBOutlet var tblDrawer: UITableView!
    @IBOutlet var lbUserName: UILabel!
    var arr = ["Home" , "DLScan" , "Inventory" , "Customers" , "Settings" , "Log Out"]

    @IBOutlet var btnProfile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblDrawer.delegate = self
        tblDrawer.dataSource = self
        tblDrawer.register(UINib(nibName: "drawerCell", bundle: nil), forCellReuseIdentifier: "drawerCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tblDrawer.tableHeaderView = vwProfile
    }
    override func viewDidLayoutSubviews() {
        let newWidth = (vwProfile.frame.size.width*77)/100
        print(newWidth)
        btnProfile.frame = CGRect(x: (newWidth/2)-50, y: (vwProfile.frame.size.height/2)-50, width: 100, height: 100)
        btnProfile.backgroundColor = UIColor.black
        btnProfile.layer.cornerRadius = 50
        lbUserName.frame = CGRect(x: 10, y: btnProfile.frame.origin.y+btnProfile.frame.size.height+10, width: newWidth-20, height: 30)
    }
    // MARK: - tableView Method(s)

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drawerCell", for: indexPath) as? drawerCell
        cell?.lbCell.text = arr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblDrawer.cellForRow(at: indexPath) as! drawerCell
        if let itemName = cell.lbCell.text{
            if itemName == "DLScan"{
                let vc = DLScanVC(nibName: "DLScanVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == "Inventory"{
                let vc = InventoryVC(nibName: "InventoryVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == "Customers"{
                let vc = CustomerListVC(nibName: "CustomerListVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == "Settings"{
                let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == "Home"{
                let vc = HomeVC(nibName: "HomeVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == "Log Out"{
                if let viewControllers = self.navigationController?.viewControllers{
                    for _ in viewControllers{
                        _ = self.navigationController?.popViewController(animated: false)
                    }
                }
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: false)
            }
        }

    }
    @IBAction func handleBtnProfile(_ sender: UIButton) {
        let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        revealSideViewController.popViewController(withNewCenter: nav, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
