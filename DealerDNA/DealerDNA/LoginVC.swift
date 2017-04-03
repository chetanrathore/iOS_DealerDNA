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
    kPhoneNo = "PhoneNo",
    kRemember = "Remember"
}

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtAutomotiveGroup: TextField!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRemember: CheckBoxButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnForgotPwd: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewHeaderBottom: UIView!
    var isRemember: Bool = false
    @IBOutlet var btnRememberMe: UIButton!
    @IBOutlet var lblNeedAccount: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var imgPhoneIcon: UIImageView!
    @IBOutlet var imgUserIcon: UIImageView!
    @IBOutlet var imgPwdIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.delegate = self
        txtPassword.delegate = self
        txtAutomotiveGroup.delegate = self
        
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
        guard let username = defaults.object(forKey: KLogin.kUserName.rawValue), let password = defaults.object(forKey: KLogin.kPassword.rawValue), let phoneNo = defaults.object(forKey: KLogin.kPhoneNo.rawValue) else {
            return
        }
        self.txtAutomotiveGroup.text = phoneNo as? String
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
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = AppColor.theamColor
        self.txtUserName.text = ""
        self.txtPassword.text = ""
        self.txtAutomotiveGroup.text = ""
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        txtUserName.backgroundColor = UIColor.white
        txtPassword.backgroundColor = UIColor.white
        txtAutomotiveGroup.backgroundColor = UIColor.white
        btnRemember.tintColor = AppColor.theamColor
        btnSignIn.backgroundColor = AppColor.theamColor
        btnSignIn.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignIn.layer.cornerRadius = 3
        viewTop.backgroundColor = AppColor.theamColor
        viewHeaderBottom.backgroundColor = AppColor.theamDarkColor
        txtUserName.font = appFont(size: AppFont.txtFontSize)
        txtPassword.font = appFont(size: AppFont.txtFontSize)
        txtAutomotiveGroup.font = appFont(size: AppFont.txtFontSize)
        btnSignUp.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignUp.setTitleColor(AppColor.theamColor, for: .normal)
        lblNeedAccount.font = appFont(size: AppFont.normalFontSize)
        (self.isRemember) ? btnRemember.did_Selected() : btnRemember.did_UnSelected()
        txtAutomotiveGroup.addTarget(self, action: #selector(textChange), for: .editingChanged)
        
        imgUserIcon.setTintColor(color: AppColor.textFieldIcon)
        imgPwdIcon.setTintColor(color: AppColor.textFieldIcon)
        imgPhoneIcon.setTintColor(color: AppColor.textFieldIcon)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtAutomotiveGroup{
            txtUserName.becomeFirstResponder()
        }else if textField == txtUserName{
            txtPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textChange(_ textField: UITextField) {
        let txt = textField.text!.trimmingCharacters(in: .whitespaces)
        formatNumber(phoneNo: txt)
    }
    
    func formatNumber(phoneNo: String){
        let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive)
        let phoneno = regex?.stringByReplacingMatches(in: phoneNo, options: [], range: NSRange(location: 0, length: phoneNo.characters.count), withTemplate: "")
        var num = phoneno!
        if num.characters.count > 10 {
            let strIndex = num.index(num.startIndex, offsetBy: 10)
            let num = num.substring(to: strIndex)
            let firstthree: String = (num as NSString).substring(with: NSRange(location: 0, length: 3))
            let secondthree: String = (num as NSString).substring(with: NSRange(location: 3, length: 3))
            let last: String = (num as NSString).substring(with: NSRange(location: 6, length: num.characters.count - 6))
            let str1 = "(" + firstthree + ") " + secondthree + "-" + last
            self.txtAutomotiveGroup.text = str1
        }else if num.characters.count >= 7{
            let firstthree: String = (num as NSString).substring(with: NSRange(location: 0, length: 3))
            let secondthree: String = (num as NSString).substring(with: NSRange(location: 3, length: 3))
            let last: String = (num as NSString).substring(with: NSRange(location: 6, length: num.characters.count - 6))
            let str1 = "(" + firstthree + ") " + secondthree + "-" + last
            self.txtAutomotiveGroup.text = str1
        }else if num.characters.count >= 4{
            let firstthree: String = (num as NSString).substring(with: NSRange(location: 0, length: 3))
            let secondthree: String = (num as NSString).substring(with: NSRange(location: 3, length: num.characters.count - 3))
            let str1 = "(" + firstthree + ") " + secondthree
            self.txtAutomotiveGroup.text = str1
        }
        
    }
    
    // MARK: Outlet Action
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
        hideKeyboard()
        
        let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive)
        let phoneno = regex?.stringByReplacingMatches(in: self.txtAutomotiveGroup.text!, options: [], range: NSRange(location: 0, length: self.txtAutomotiveGroup.text!.characters.count), withTemplate: "")
        if txtAutomotiveGroup.isEmpty() && txtUserName.isEmpty() && txtPassword.isEmpty(){
            showAlertView(title: "Message", message: "Please fill in all fields.", view: self)
        }else if(txtAutomotiveGroup.isEmpty()){
            showAlertView(title: "Message", message: "Phone number is required.", view: self)
        }   else if phoneno?.characters.count != 10{
            showAlertView(title: "Message", message: "Phone number is invalid.", view: self)
        }else if(txtUserName.isEmpty()){
            showAlertView(title: "Message", message: "Username is required.", view: self)
        }else if(txtPassword.isEmpty()){
            showAlertView(title: "Message", message: "Password is required.", view: self)
        }else if(!isValidPassword(strPassword: txtPassword.text!)){
            showAlertView(title: "Message", message: "Password must contain atleast 8 characters.", view: self)
        }else{
            let username = txtUserName.text!.trimmingCharacters(in: .whitespaces)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespaces)
            let phoneNo = txtAutomotiveGroup.text!.trimmingCharacters(in: .whitespaces)
            let defaults = UserDefaults()
            if btnRemember.is_Selected(){
                defaults.set(phoneNo, forKey: KLogin.kPhoneNo.rawValue)
                defaults.set(username, forKey: KLogin.kUserName.rawValue)
                defaults.set(password, forKey: KLogin.kPassword.rawValue)
                defaults.set(true, forKey: KLogin.kRemember.rawValue)
            }else{
                defaults.removeObject(forKey: KLogin.kPhoneNo.rawValue)
                defaults.removeObject(forKey: KLogin.kRemember.rawValue)
                defaults.removeObject(forKey: KLogin.kUserName.rawValue)
                defaults.removeObject(forKey: KLogin.kPassword.rawValue)
            }
            
            appDelegate.sideMenuItem.add(DashBoardMenu.home)
            appDelegate.sideMenuItem.add(DashBoardMenu.dlScan)
            appDelegate.sideMenuItem.add(DashBoardMenu.inventory)
            appDelegate.sideMenuItem.add(DashBoardMenu.customer)
            appDelegate.sideMenuItem.add(DashBoardMenu.setting)
            appDelegate.sideMenuItem.add(DashBoardMenu.logout)
            
            appDelegate.dashBoardTiles.add(DashBoardMenu.home)
            appDelegate.dashBoardTiles.add(DashBoardMenu.dlScan)
            appDelegate.dashBoardTiles.add(DashBoardMenu.inventory)
            appDelegate.dashBoardTiles.add(DashBoardMenu.customer)
            appDelegate.dashBoardTiles.add(DashBoardMenu.setting)
    
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
        //        self.present(registerVC, animated:true, completion: nil)
    }
    
    // MARK: Custom Methods
    func hideKeyboard(){
        if txtAutomotiveGroup.isFirstResponder{
            txtAutomotiveGroup.resignFirstResponder()
        }
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
