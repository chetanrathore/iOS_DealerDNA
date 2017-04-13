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
    var arrSection = [Dasdhboard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpDashboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        setInterface()
        appDelegate.tabAppts = "31"
        appDelegate.tabTasks = "234"
        appDelegate.setBadgeValue(viewWithTabbar: self)
        
    }
    
    func setView(){
        self.tblDashboard.dataSource = self
        self.tblDashboard.delegate = self
        self.tblDashboard.register(UINib(nibName: "DashboardCell",bundle: nil), forCellReuseIdentifier: "DashboardCell")
        self.tblDashboard.tableFooterView = UIView()
    }
    
    func setInterface(){
        self.navigationController?.navigationBar.isHidden = true
        self.btnDate.titleLabel?.font = appFont(size: AppFont.normalFontSize, fontWeight: .kBold)
        self.lblTitle.font = appFont(size: AppFont.normalFontSize, fontWeight: .kHeavy)
        self.lblSubTitle.font = appFont(size: AppFont.normalFontSize, fontWeight: .kSemiBold)
    }
    
    func setUpDashboard(){
        arrSection.removeAll()
        let d1 = DashboadMster(title: "Working", count: 10, backColor: AppColor.lightBlueColor)
        let d2 = DashboadMster(title: "Accepted", count: 9, backColor: AppColor.lightGreenColor)
        let d3 = DashboadMster(title: "Forgotten", count: 133, backColor: AppColor.darkRedColor)
        let d4 = DashboadMster(title: "Unassigned", count: 3, backColor: AppColor.yellowColor)
        arrSection.append(Dasdhboard(mainTitle: "Opportunities", subSection: [d1,d2,d3,d4]))
        
        let d21 = DashboadMster(title: "Email Reply", count: 13, backColor: AppColor.lightBlueColor)
        let d22 = DashboadMster(title: "Call", count: 9, backColor: AppColor.lightBlueColor)
        let d23 = DashboadMster(title: "Waiting Reply", count: 8, backColor: AppColor.darkRedColor)
        let d24 = DashboadMster(title: "Text/SMS", count: 32, backColor: AppColor.lightBlueColor)
        arrSection.append(Dasdhboard(mainTitle: "Follow Up", subSection: [d21,d22,d23,d24]))
        
        let d31 = DashboadMster(title: "Today", count: 13, backColor: AppColor.lightBlueColor)
        let d32 = DashboadMster(title: "Confirmed", count: 8, backColor: AppColor.lightGreenColor)
        let d33 = DashboadMster(title: "Missed", count: 9, backColor: AppColor.darkRedColor)
        let d34 = DashboadMster(title: "Rescheduled", count: 2, backColor: AppColor.lightBlueColor)
        arrSection.append(Dasdhboard(mainTitle: "Appoinments", subSection: [d31,d32,d33,d34]))
        
        let d41 = DashboadMster(title: "Logged", count: 13, backColor: AppColor.lightBlueColor)
        let d42 = DashboadMster(title: "Demo", count: 8, backColor: AppColor.lightBlueColor)
        let d43 = DashboadMster(title: "Write Up", count: 9, backColor: AppColor.lightBlueColor)
        arrSection.append(Dasdhboard(mainTitle: "Showroom", subSection: [d41,d42,d43]))
        tblDashboard.reloadData()
        
    }
    
    // Mark: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
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
        label.text = arrSection[section].mainTitle
        label.font =  appFont(size: AppFont.normalFontSize, fontWeight: .kBold)
        label.textColor = UIColor.darkGray
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrSection[indexPath.section].subSection.count == 3{
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
        return self.arrSection[section].subSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionCell", for: indexPath) as! DashboardCollectionCell
        //print(collectionView.tag)
        let data = arrSection[collectionView.tag].subSection[indexPath.row]
        cell.lblTitle.text = data.title
        cell.lblCount.text = String(data.count)
        cell.vwBack.backgroundColor = data.backColor
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
        //        print(collectionView.tag)
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
