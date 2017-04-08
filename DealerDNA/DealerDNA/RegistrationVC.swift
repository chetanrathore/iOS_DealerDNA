//
//  RegistrationVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtAutomotiveGroup: TextField!
    @IBOutlet var txtDealerShipName: TextField!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPwd: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewHeaderBottom: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblAlreadyAccount: UILabel!
    
    @IBOutlet var textFieldIcon: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAutomotiveGroup.delegate = self
        txtDealerShipName.delegate = self
        txtPassword.delegate = self
        txtUserName.delegate = self
        txtEmail.delegate = self
        txtConfirmPwd.delegate = self
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
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = AppColor.theamColor
        txtUserName.backgroundColor = UIColor.white
        txtPassword.backgroundColor = UIColor.white
        txtConfirmPwd.backgroundColor = UIColor.white
        txtEmail.backgroundColor = UIColor.white
        txtAutomotiveGroup.backgroundColor = UIColor.white
        txtDealerShipName.backgroundColor = UIColor.white
        
        btnSignUp.backgroundColor = AppColor.theamColor
        btnSignUp.layer.cornerRadius = 3
        btnSignIn.titleLabel?.font = appFont(size: AppFont.normalFontSize)
        btnSignIn.setTitleColor(AppColor.theamColor, for: .normal)
        lblAlreadyAccount.font = appFont(size: AppFont.normalFontSize)
        //  lblTitle.font = appFont(size: AppFont.titleFontSize)
        viewTop.backgroundColor = AppColor.theamColor
        viewHeaderBottom.backgroundColor = AppColor.theamDarkColor
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        for icon in textFieldIcon{
            icon.setTintColor(color: AppColor.textFieldIcon)
        }
        txtAutomotiveGroup.addTarget(self, action: #selector(textChange), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtAutomotiveGroup{
            txtDealerShipName.becomeFirstResponder()
        }else if textField == txtDealerShipName{
            txtUserName.becomeFirstResponder()
        }else if textField == txtUserName{
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            txtConfirmPwd.becomeFirstResponder()
        }else if textField == txtConfirmPwd{
            txtEmail.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: Outlet Actions
    
    @IBAction func handleBtnSignUp(_ sender: UIButton) {
        hideKeyboard()
        if txtUserName.isEmpty() && txtPassword.isEmpty() && txtAutomotiveGroup.isEmpty() && txtEmail.isEmpty(){
            showAlertView(title: "Message", message: "Please fill in all fields.", view: self)
        }else if(txtAutomotiveGroup.isEmpty()){
            showAlertView(title: "Message", message: "Username is required.", view: self)
        }else if(txtUserName.isEmpty()){
            showAlertView(title: "Message", message: "Username is required.", view: self)
        }else if(txtPassword.isEmpty()){
            showAlertView(title: "Message", message: "Password is required.", view: self)
        }else if(!isValidPassword(strPassword: txtPassword.text!)){
            showAlertView(title: "Message", message: "Password must contain atleast 8 characters.", view: self)
        }else if(txtConfirmPwd.isEmpty()){
            showAlertView(title: "Message", message: "Please confirm your password.", view: self)
        }else if(txtPassword.text! == txtConfirmPwd.text!){
            showAlertView(title: "Message", message: "Your password and confirm password do not match.", view: self)
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
        if txtAutomotiveGroup.isFirstResponder{
            txtAutomotiveGroup.resignFirstResponder()
            return
        }
        if txtDealerShipName.isFirstResponder{
            txtDealerShipName.resignFirstResponder()
        }
        if txtUserName.isFirstResponder{
            txtUserName.resignFirstResponder()
        }
        if txtEmail.isFirstResponder{
            txtEmail.resignFirstResponder()
        }
        if txtPassword.isFirstResponder{
            txtPassword.resignFirstResponder()
        }
        if txtConfirmPwd.isFirstResponder{
            txtConfirmPwd.resignFirstResponder()
        }
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
    
    
}
