//
//  RegistrationVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPwd: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
    
    // MARK: Interface design
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: Outlet Actions
    
    @IBAction func handleBtnSignUp(_ sender: UIButton) {
        
    }
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.isContain(view: loginVC)
        self.navigationController?.pushViewController(loginVC, animated: false)
        
    }
    
}
