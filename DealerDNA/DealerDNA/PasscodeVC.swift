//
//  PasscodeVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/8/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import PPRevealSideViewController

class PasscodeVC: UIViewController {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var pinDotViews: [UIView]!
    @IBOutlet var vwKeyPad: [UIView]!
    @IBOutlet var btnKeyPad: [UIButton]!
    @IBOutlet var lblButtonTitle: UILabel!
    @IBOutlet var vwDots: UIView!
    @IBOutlet var constCenterDotViww: NSLayoutConstraint!
    @IBOutlet var btnSetPasscode: UIButton!
    @IBOutlet var btnCancelBack: UIButton!
    
    var x = 0
    var strPasscode: String = ""
    var enterePasscode = ""
    var passcodeVCFor: kPasscode = .kChangePasscode
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setInterface()
    }
    
    override func viewDidLayoutSubviews() {
        x = Int(self.vwDots.frame.origin.x)
    }
    
    func setInterface(){
        self.strPasscode = ""
        self.btnCancelBack.isHidden = false
        switch passcodeVCFor {
        case .kCheckPasscode:
            self.lblTitle.text = "Enter passcode"
            self.lblButtonTitle.text = "Cancel"
            self.btnCancelBack.isHidden = true
            break
        case .kCreatePasscode:
            self.lblTitle.text = "Enter New passcode"
            self.lblButtonTitle.text = "Cancel"
            break
        case .kChangePasscode:
            self.lblTitle.text = "Enter your current passcode"
            self.lblButtonTitle.text = "Cancel"
            break
        }
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(colorLiteralRed: 26/255, green: 48/255, blue: 64/255, alpha: 1.0)
        for view in vwKeyPad{
            view.layer.cornerRadius = (Screen.device == .pad) ?  40 : 35
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor(colorLiteralRed: 37/255, green: 111/255, blue: 183/255, alpha: 1.0).cgColor
            view.clipsToBounds = true
        }
        
        for dotView in pinDotViews{
            dotView.layer.cornerRadius = (Screen.device == .pad) ?  10 : 7.5
            dotView.layer.borderWidth = 1
            dotView.layer.borderColor = UIColor(colorLiteralRed: 37/255, green: 111/255, blue: 183/255, alpha: 1.0).cgColor
            dotView.backgroundColor = UIColor.clear
        }
    }
    
    //Handle Passcode here
    @IBAction func btnHandlePassCode(_ sender: UIButton) {
        if sender.tag == 5{
            setPasscodeInKeyChain()
            self.passcodeVCFor = .kChangePasscode
            self.btnSetPasscode.tag = 0
            self.setInterface()
        }else{
            for dotView in self.pinDotViews{
                dotView.backgroundColor = UIColor.clear
            }
            self.strPasscode = ""
        }
    }
    
    @IBAction func handleBtnKey(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.backgroundColor = UIColor(colorLiteralRed: 37/255, green: 111/255, blue: 183/255, alpha: 1.0)
        }) { (completed) in
            sender.backgroundColor = UIColor.clear
        }
        if self.strPasscode.characters.count <= 4{
            if(self.strPasscode.characters.count < 4){
                self.strPasscode.append(String(sender.tag))
            }
            fillView()
            if self.strPasscode.characters.count == 4{
                switch self.passcodeVCFor {
                case .kCheckPasscode:
                    self.checkPasscode()
                    break;
                case .kCreatePasscode:
                    self.setPasscode()
                    break;
                case .kChangePasscode:
                    self.changePasscode()
                    break
                }
            }
        }
    }
    
    func fillView(){
        let count = self.strPasscode.characters.count
        for dotView in self.pinDotViews{
            if dotView.tag < count{
                dotView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            }
        }
    }
    
    func wrongPin(){
        UIView.animate(withDuration: 0.1, animations: {
            self.vwDots.frame = CGRect(x: CGFloat(self.x - 30), y: self.vwDots.frame.origin.y, width: self.vwDots.frame.width, height: self.vwDots.frame.height)
        }) { (completed) in
            UIView.animate(withDuration: 0.1, animations: {
                self.vwDots.frame = CGRect(x: CGFloat(self.x + 30), y: self.vwDots.frame.origin.y, width: self.vwDots.frame.width, height: self.vwDots.frame.height)
            }) { (completed) in
                self.vwDots.frame = CGRect(x: CGFloat(self.x), y: self.vwDots.frame.origin.y, width: self.vwDots.frame.width, height: self.vwDots.frame.height)
                self.strPasscode = ""
                for dotView in self.pinDotViews{
                    dotView.backgroundColor = UIColor.clear
                }
            }
        }
    }
    
    func checkPasscode(){
        guard let passcode = KeychainWrapper.standard.string(forKey: kSecValueData as String) else{
            return
        }
        if self.strPasscode == passcode{
            print("Valid passcode")
            let main = HomeVC(nibName: "HomeVC", bundle: nil)
            let revealSideViewController = PPRevealSideViewController(rootViewController: UINavigationController(rootViewController: main))
            revealSideViewController?.directionsToShowBounce = .none
            revealSideViewController?.resetOption(.optionsiOS7StatusBarFading)
            revealSideViewController?.setOption(.optionsNoStatusBar)
           self.view.window?.rootViewController = revealSideViewController
        
            
        }else{
            wrongPin()
        }
    }
    
    func setPasscode(){
        if self.enterePasscode == ""{
            self.enterePasscode = self.strPasscode
            self.strPasscode = ""
            self.lblTitle.text = "Confirm Passcode"
            for dotView in self.pinDotViews{
                dotView.backgroundColor = UIColor.clear
            }
        }else{
            if self.enterePasscode == self.strPasscode{
                self.lblButtonTitle.text = "Save"
                self.btnSetPasscode.tag = 5
            }else{
                self.wrongPin()
            }
        }
    }
    
    func changePasscode(){
        let passcode = KeychainWrapper.standard.string(forKey: kSecValueData as String)
        if passcode == self.strPasscode{
            self.passcodeVCFor = .kCreatePasscode
            self.setInterface()
        }else{
            self.wrongPin()
        }
    }
    
    func setPasscodeInKeyChain(){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(self.strPasscode, forKey: kSecValueData as String)
        let passcode = KeychainWrapper.standard.string(forKey: kSecValueData as String)
        print(passcode!)
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: isSetPasscode)
        userDefault.synchronize()
        showAlertView(title: "Message", message: "Your passcode successfully set", view: self)
        self.setInterface()
    }
    
    @IBAction func btnCancelBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
