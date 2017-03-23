//
//  LoginVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

enum KLogin: String{
    case kUserName = "UserName",
    kPassword = "Password",
    kRemember = "Remember"
}

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRemember: CheckBoxButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnForgotPwd: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var viewTop: UIView!
    var isRemember: Bool = false
    @IBOutlet var btnRememberMe: UIButton!
    @IBOutlet var lblNeedAccount: UILabel!
    @IBOutlet var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.delegate = self
        txtPassword.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        let defaults = UserDefaults()
        guard let isRemember = defaults.object(forKey: KLogin.kRemember.rawValue) else {
            return
        }
        self.isRemember = isRemember as! Bool
        guard let username = defaults.object(forKey: KLogin.kUserName.rawValue), let password = defaults.object(forKey: KLogin.kPassword.rawValue) else {
            return
        }
        self.txtUserName.text = username as? String
        self.txtPassword.text = password as? String
        (self.isRemember) ? btnRemember.did_Selected() : btnRemember.did_UnSelected()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
    }
    
    // MARK: Interface design
    
    func setLayout() {
        self.txtUserName.text = ""
        self.txtPassword.text = ""
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        txtUserName.backgroundColor = UIColor.white
        txtPassword.backgroundColor = UIColor.white
        btnRemember.tintColor = AppColor.theamColor
        btnSignIn.backgroundColor = AppColor.theamColor
        btnSignIn.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignIn.layer.cornerRadius = 5
        viewTop.backgroundColor = AppColor.theamColor
        txtUserName.font = appFont(size: AppFont.txtFontSize)
        txtPassword.font = appFont(size: AppFont.txtFontSize)
        btnSignUp.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignUp.setTitleColor(AppColor.theamColor, for: .normal)
        lblNeedAccount.font = appFont(size: AppFont.normalFontSize)
        lblTitle.font = appFont(size: AppFont.titleFontSize)
        (self.isRemember) ? btnRemember.did_Selected() : btnRemember.did_UnSelected()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUserName{
            txtPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: Outlet Action
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
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
            let username = txtUserName.text!.trimmingCharacters(in: .whitespaces)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespaces)
            let defaults = UserDefaults()
            if btnRemember.is_Selected(){
                defaults.set(username, forKey: KLogin.kUserName.rawValue)
                defaults.set(password, forKey: KLogin.kPassword.rawValue)
                defaults.set(true, forKey: KLogin.kRemember.rawValue)
            }else{
                defaults.removeObject(forKey: KLogin.kRemember.rawValue)
                defaults.removeObject(forKey: KLogin.kUserName.rawValue)
                defaults.removeObject(forKey: KLogin.kPassword.rawValue)
            }
            let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    @IBAction func handleBtnRememberMe(_ sender: UIButton) {
        if sender.tag == 1{
            if self.isRemember{
                self.isRemember = false
                btnRemember.did_UnSelected()
            }else{
                self.isRemember = true
                btnRemember.did_Selected()
            }
        }else{
            if btnRemember.is_Selected(){
                self.isRemember = false
            }else{
                self.isRemember = true
            }
        }
    }
    
    @IBAction func handleBtnLostPwd(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnSignUp(_ sender: UIButton) {
        let registerVC = RegistrationVC(nibName: "RegistrationVC", bundle: nil)
        self.navigationController?.isContain(view: registerVC)
        self.navigationController?.pushViewController(registerVC, animated: false)
    }
    
    // MARK: Custom Methods
    func hideKeyboard(){
        if txtUserName.isFirstResponder{
            txtUserName.resignFirstResponder()
        }
        if txtPassword.isFirstResponder{
            txtPassword.resignFirstResponder()
        }
    }
    
    func showAlert(title: String, message: String, cancelButtonTitle: String = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}
