//
//  DrawerVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class DrawerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var vwTop: UIView!
    @IBOutlet var vwProfile: UIView!
    @IBOutlet var vwProfileDetail: UIView!
    @IBOutlet var tblDrawer: UITableView!
    @IBOutlet var lbUserName: UILabel!
    @IBOutlet var lblPosition: UILabel!
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
        //        tblDrawer.tableHeaderView = vwProfile
        
        self.view.backgroundColor = AppColor.sideBarColor
    }
    
    override func viewDidLayoutSubviews() {
        //        let newWidth = (vwProfile.frame.size.width*77)/100
        //        print(newWidth)
        //    btnProfile.frame = CGRect(x: (newWidth/2)-50, y: (vwProfile.frame.size.height/2)-50, width: 100, height: 100)
        //        btnProfile.backgroundColor = UIColor.black
        //        btnProfile.layer.cornerRadius = btnProfile.bounds.width/2
        //  lbUserName.frame = CGRect(x: 10, y: btnProfile.frame.origin.y+btnProfile.frame.size.height+10, width: newWidth-20, height: 30)
        btnProfile.layer.cornerRadius = btnProfile.bounds.width/2
        btnProfile.layer.borderWidth = 2
        btnProfile.layer.borderColor = AppColor.theamColor.cgColor
        vwTop.backgroundColor = AppColor.theamColor
        vwProfileDetail.backgroundColor = AppColor.sideBarColor
        lbUserName.textColor = UIColor.white.withAlphaComponent(0.8)
        lblPosition.textColor = UIColor.gray
        
    }
    
    // MARK: - tableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arr.count
        return appDelegate.sideMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drawerCell", for: indexPath) as? drawerCell
        if indexPath.row == 0{
            cell?.v1.isHidden = true
        }
        if indexPath.row == appDelegate.sideMenuItem.count - 1{
            cell?.v2.isHidden = true
        }
        let str = appDelegate.sideMenuItem.object(at: indexPath.row) as! String
        
        if str == DashBoardMenu.customer{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_customer")
        }else if str == DashBoardMenu.dlScan{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_dlscan")
        }else if str == DashBoardMenu.home{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_home")
        }else if str == DashBoardMenu.setting{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_setting")
        }else if str == DashBoardMenu.inventory{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_invetory")
        }else if str == DashBoardMenu.logout{
            cell?.imgMenuIcon.image = #imageLiteral(resourceName: "m_signout")
        }
        if str == appDelegate.selectedMenu{
            cell?.selectedCell()
        }else{
            cell?.otherCell()
        }
        cell?.lblMenuTitle.text = str
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = appDelegate.sideMenuItem.object(at: indexPath.row) as! String
        appDelegate.selectedMenu = str
        let cell = tblDrawer.cellForRow(at: indexPath) as! drawerCell
        if let itemName = cell.lblMenuTitle.text{
            if itemName == DashBoardMenu.home{
                 let vc = TabbarVC()
//                let vc = HomeVC(nibName: "HomeVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == DashBoardMenu.dlScan{
                let vc = DLScanVC(nibName: "DLScanVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == DashBoardMenu.inventory{
                let vc = InventoryVC(nibName: "InventoryVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == DashBoardMenu.customer{
                let vc = CustomerListVC(nibName: "CustomerListVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == DashBoardMenu.setting{
                let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: true)
            }else if itemName == DashBoardMenu.logout{
                if let viewControllers = self.navigationController?.viewControllers{
                    for _ in viewControllers{
                        _ = self.navigationController?.popViewController(animated: false)
                    }
                }
                appDelegate.logut()
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                let nav = UINavigationController(rootViewController: vc)
                revealSideViewController.popViewController(withNewCenter: nav, animated: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Screen.device == .pad{
            return 60
        }
        return 44
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
