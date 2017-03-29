//
//  Constants.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import UIKit

var appDelegate: AppDelegate{
    struct Singleton{
        static let instance = AppDelegate()
    }
    return Singleton.instance
}

struct Constants{
    
    struct AppUrl {
        
    }
    
    struct Alerts {
        
    }
    
    struct Strings {
        
    }
    
}

struct AppFont {
    static let fontName = "Helvetica Neue"
    static let  normalFontSize: CGFloat = (Screen.device == .pad) ? 25 : 15
    static let  txtFontSize: CGFloat = (Screen.device == .pad) ? 25 : 15
    static let  titleFontSize: CGFloat = (Screen.device == .pad) ? 30 : 20
}

struct AppColor {
    static let textFieldColor = UIColor.white
    static let theamColor = UIColor(colorLiteralRed: 129/255, green: 183/255, blue: 26/255, alpha: 1)
    static let theamDarkColor = UIColor(colorLiteralRed: 107/255, green: 152/255, blue: 22/255, alpha: 1)
}

struct Screen {
    static let device = UIDevice.current.userInterfaceIdiom
    static var screenWidth = UIScreen.main.bounds.width
    static var screenHeight = UIScreen.main.bounds.height
}

// MARK: Validations

func isValidEmail(strEmail : String) ->  Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: strEmail)
}

func isValidPassword(strPassword : String) -> Bool{
    let totalChar = strPassword.characters.count
    return totalChar > 8
}

func appFont(size: CGFloat = AppFont.normalFontSize) -> UIFont{
    var font = UIFont(name: AppFont.fontName, size: size)!
    if size == AppFont.titleFontSize{
        font = UIFont.boldSystemFont(ofSize: AppFont.titleFontSize)
    }
    return font
    
}

func showAlertView(title: String, message: String, cancelButtonTitle: String = "Ok",view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
    alert.addAction(ok)
    view.present(alert, animated: true, completion: nil)
}



