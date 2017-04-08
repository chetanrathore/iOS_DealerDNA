//
//  PasscodeVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/8/17.
//  Copyright © 2017 developer93. All rights reserved.
//

enum kPasscode {
    case kCheckPasscode,
    kCurrentPasscode,
    kChangePasscode
}

import UIKit

class PasscodeVC: UIViewController {
    
    @IBOutlet var pinDotViews: [UIView]!
    
    @IBOutlet var vwKeyPad: [UIView]!
    
    @IBOutlet var btnKeyPad: [UIButton]!
    
    @IBOutlet var vwDots: UIView!
    
    @IBOutlet var constCenterDotViww: NSLayoutConstraint!
    var x = 0
    var strPasscode: String = ""
    
    
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
        let passcode: kPasscode = .kCheckPasscode
        switch passcode {
        case .kCheckPasscode:
            for dotView in self.pinDotViews{
                dotView.backgroundColor = UIColor.clear
            }
            self.strPasscode = ""
            break
        default:
            break
        }
    }
    
    @IBAction func handleBtnKey(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.backgroundColor = UIColor(colorLiteralRed: 37/255, green: 111/255, blue: 183/255, alpha: 0.7)
        }) { (completed) in
            sender.backgroundColor = UIColor.clear
        }
        
        if self.strPasscode.characters.count < 4{
            self.strPasscode.append(String(sender.tag))
            fillView()
        }else if self.strPasscode.characters.count == 4{
//            setInKeyChain()
        }
        else{
//            wrongPin()
        }
        
    }
    
    func fillView(){
        let count = self.strPasscode.characters.count
        for dotView in self.pinDotViews{
            if dotView.tag < count{
                dotView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
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
    
    func setInKeyChain(){
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.setValue(self.strPasscode, forKey: kSecValueData as String)
        keychainWrapper.writeToKeychain()
        
        print(keychainWrapper.myObject(forKey: "kPasscode"))
    }
    
}
