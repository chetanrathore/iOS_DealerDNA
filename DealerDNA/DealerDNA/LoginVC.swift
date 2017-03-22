//
//  LoginVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRemember: CheckBoxButton!
    var isRemember: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
    }
  
    // MARK: Interface design
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        txtUserName.backgroundColor = UIColor.white
        txtUserName.layer.borderColor = nil
        txtUserName.clipsToBounds = true
        (self.isRemember) ? btnRemember.did_Selected() : btnRemember.did_UnSelected()
        
    }
    
    // MARK: Outlet Action
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
        let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
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
 
}
