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
    var arr = ["DLScan" , "Inventory" , "Customers" , "Settings" , "Log Out"]

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

    // MARK: - tableView Method(s)

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
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
                revealSideViewController.popViewController(withNewCenter: vc, animated: true)
            }else if itemName == "Inventory"{
                let vc = InventoryVC(nibName: "InventoryVC", bundle: nil)
                revealSideViewController.popViewController(withNewCenter: vc, animated: true)
            }else if itemName == "Customers"{
                let vc = CustomerListVC(nibName: "CustomerListVC", bundle: nil)
                revealSideViewController.popViewController(withNewCenter: vc, animated: true)
            }else if itemName == "Settings"{
                let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
                revealSideViewController.popViewController(withNewCenter: vc, animated: true)
            }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
