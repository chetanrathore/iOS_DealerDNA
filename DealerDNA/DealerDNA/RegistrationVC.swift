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
    @IBOutlet var viewTop: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblAlreadyAccount: UILabel!
    
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

        txtUserName.backgroundColor = UIColor.white
        txtPassword.backgroundColor = UIColor.white
        txtConfirmPwd.backgroundColor = UIColor.white
        txtEmail.backgroundColor = UIColor.white
        btnSignUp.backgroundColor = AppColor.theamColor
        btnSignUp.layer.cornerRadius = 5
        btnSignIn.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignIn.setTitleColor(AppColor.theamColor, for: .normal)
        lblAlreadyAccount.font = appFont(size: AppFont.normalFontSize)
        lblTitle.font = appFont(size: AppFont.titleFontSize)
        viewTop.backgroundColor = AppColor.theamColor

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    // MARK: Outlet Actions
    
    @IBAction func handleBtnSignUp(_ sender: UIButton) {
        hideKeyboard()
        if txtUserName.isEmpty() && txtPassword.isEmpty(){
            showAlertView(title: "Message", message: "Username and password are required.", view: self)
        }else if(txtUserName.isEmpty()){
            showAlertView(title: "Message", message: "Username is required.", view: self)
        }else if(txtPassword.isEmpty()){
            showAlertView(title: "Message", message: "Password is required.", view: self)
        }else if(!isValidPassword(strPassword: txtPassword.text!)){
            showAlertView(title: "Message", message: "Password must contain atleast 8 characters.", view: self)
        }else{
            let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController?.pushViewController(loginVC, animated: false)
        }
    }
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.isContain(view: loginVC)
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
    // MARK: Custom Methods
    func hideKeyboard(){
    }
    
}
