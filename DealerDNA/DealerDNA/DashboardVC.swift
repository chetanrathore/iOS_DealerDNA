//
//  DashboardVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/5/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var vwNavigation: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var tblDashboard: UITableView!
    @IBOutlet var btnDate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        setInterface()
        appDelegate.tabAppts = "434"
        appDelegate.setBadgeValue(viewWithTabbar: self)
        tblDashboard.reloadData()
    }
    
    func setView(){
        self.tblDashboard.dataSource = self
        self.tblDashboard.delegate = self
        self.tblDashboard.register(UINib(nibName: "DashboardCell",bundle: nil), forCellReuseIdentifier: "DashboardCell")
    }
    
    func setInterface(){
        self.navigationController?.navigationBar.isHidden = true
        self.btnDate.titleLabel?.font = appFont(size: AppFont.normalFontSize, fontWeight: .kBold)
        self.lblTitle.font = appFont(size: AppFont.normalFontSize, fontWeight: .kHeavy)
        self.lblSubTitle.font = appFont(size: AppFont.normalFontSize, fontWeight: .kSemiBold)
    }
    
    // Mark: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.cvcStatus.register(UINib(nibName:"DashboardCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCollectionCell")
        cell.cvcStatus.dataSource = self
        cell.cvcStatus.delegate = self
        cell.cvcStatus.tag = indexPath.section
        cell.cvcStatus.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: (Screen.device == .pad) ? 45 : 35))
        returnedView.backgroundColor = UIColor.groupTableViewBackground
        let height = CGFloat((Screen.device == .pad) ? 35 : 30)
        let label = UILabel(frame: CGRect(x: 10, y: (returnedView.frame.height-height)/2 , width: view.frame.size.width, height: height))
        label.text = "Temp 1"
        label.font =  appFont(size: AppFont.normalFontSize, fontWeight: .kBold)
        label.textColor = UIColor.darkGray
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            if Screen.device == .pad{
                return 80 + 20
            }
            return 55 + 20
            
        }
        if Screen.device == .pad{
            return 160 + 30
        }
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (Screen.device == .pad) ? 45 : 35
    }
    
    // Mark: Collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        if collectionView.tag == 1{
            return 3
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionCell", for: indexPath) as! DashboardCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.bounds.width / 3 - 6
        if Screen.device == .pad{
            return CGSize(width: size, height: 80)
        }
        return CGSize(width: size, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.tag)
    }
    
    //Mark: Outlet action
    
    @IBAction func handleBtnMenu(_ sender: UIButton) {
        let vc = DrawerVC(nibName: "DrawerVC", bundle: nil)
        revealSideViewController.push(vc, on: .left, animated: true)
    }
    
    @IBAction func handleBtnUser(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnInventory(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnAdd(_ sender: UIButton) {
    }
    
    
}
