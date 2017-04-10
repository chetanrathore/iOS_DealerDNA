//
//  SettingsVC.swift
//  DealerDNA
//
//  Created by Developer49 on 22/03/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, CustomNevigationDeletegate, UITableViewDataSource, UITableViewDelegate {
    
    let customNav = CustomNavigationBar()
    @IBOutlet var tblSettings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSettings.dataSource = self
        tblSettings.delegate = self
        tblSettings.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        customNav.createView(self.view, title: "Settings", backBtn: .menu, rightBtnTitle: nil, rightButtonImage: nil)
        customNav.delegate = self
    }
    
    func btnLeftClick() {
        let vc = DrawerVC(nibName: "DrawerVC", bundle: nil)
        revealSideViewController.push(vc, on: .left, animated: true)
    }
    
    // MARK: - tableView Method(s)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arr.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passcode = PasscodeVC(nibName: "PasscodeVC", bundle: nil)
        if KeychainWrapper.standard.string(forKey: kSecValueData as String) != nil{
            passcode.passcodeVCFor = .kChangePasscode
        }else{
            passcode.passcodeVCFor = .kCreatePasscode
            
        }
        self.navigationController?.present(passcode, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Screen.device == .pad{
            return 60
        }
        return 44
    }
    
}
