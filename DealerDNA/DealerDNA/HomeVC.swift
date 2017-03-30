//
//  HomeVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class HomeVC: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var btnLogOut: UIButton!
    @IBOutlet var collectionViewHome: UICollectionView!
    var arrItems = ["DLScan" , "Inventory" , "Customers" , "Settings"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewHome.delegate = self
        collectionViewHome.dataSource = self
        collectionViewHome.register(UINib(nibName: "homeScreenCell", bundle: nil), forCellWithReuseIdentifier: "homeScreenCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
    // MARK: CollectionView Method(s)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return arrItems.count
        return appDelegate.dashBoardTiles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeScreenCell", for: indexPath) as? homeScreenCell
        let str = appDelegate.dashBoardTiles[indexPath.row] as! String
        cell?.lbCell.text = str
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = collectionViewHome.frame.size.width/3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionViewHome.cellForItem(at: indexPath) as? homeScreenCell
        if let itemName = appDelegate.dashBoardTiles[indexPath.row] as? String{
            appDelegate.selectedMenu = itemName
            if itemName == DashBoardMenu.dlScan{
                let vc = DLScanVC(nibName: "DLScanVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.inventory{
                let vc = InventoryVC(nibName: "InventoryVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.customer{
                let vc = CustomerListVC(nibName: "CustomerListVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.setting{
                let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    // MARK: Interface design
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        btnLogOut.layer.borderColor = UIColor.white.cgColor
        btnLogOut.layer.borderWidth = 1.5
        btnLogOut.layer.cornerRadius = 5
    }
    
    // MARK: Outlet Action
    
    @IBAction func handleBtnLogOut(_ sender: Any) {
        if let viewControllers = self.navigationController?.viewControllers{
            for _ in viewControllers{
                _ = self.navigationController?.popViewController(animated: false)
            }
        }
        appDelegate.logut()
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
