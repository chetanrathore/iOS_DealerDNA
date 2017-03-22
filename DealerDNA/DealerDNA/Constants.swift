//
//  Constants.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import UIKit

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
    static let theamColor = UIColor(colorLiteralRed: 110/255, green: 168/255, blue: 20/255, alpha: 1)
    
}

struct Screen {
    static let device = UIDevice.current.userInterfaceIdiom
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
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
    let font = UIFont(name: AppFont.fontName, size: size)!
    return font
}

func showAlertView(title: String, message: String, cancelButtonTitle: String = "Ok",view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
    alert.addAction(ok)
    view.present(alert, animated: true, completion: nil)
}



