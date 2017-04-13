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
//Bold


enum FontWeight{
    case
    kMedium,
    kBold,
    kItalic,
    kRegular,
    kHeavy,
    kLight,
    kSemiBold
}

struct AppFont {
    static let fontName = "Helvetica Neue"
    static let  normalFontSize: CGFloat = (Screen.device == .pad) ? 20 : 15
    static let  txtFontSize: CGFloat = (Screen.device == .pad) ? 20 : 15
    static let  titleFontSize: CGFloat = (Screen.device == .pad) ? 25 : 20
}

struct AppColor {
    static let greenColor = UIColor(colorLiteralRed: 6/255, green: 171/255, blue: 26/255, alpha: 1)
    
    static let textFieldColor = UIColor.white
    static let theamColor = UIColor(colorLiteralRed: 6/255, green: 171/255, blue: 26/255, alpha: 1)//UIColor(colorLiteralRed: 129/255, green: 183/255, blue: 26/255, alpha: 1)
    static let theamDarkColor = UIColor(colorLiteralRed: 6/255, green: 171/255, blue: 26/255, alpha: 1)//UIColor(colorLiteralRed: 107/255, green: 152/255, blue: 22/255, alpha: 1)
    static let textFieldIcon = UIColor.gray
    
    static let sideBarColor = UIColor(colorLiteralRed: 41/255, green: 41/255, blue: 41/255, alpha: 1)
    static let selectedSideBarColor = UIColor(colorLiteralRed: 60/255, green: 60/255, blue: 60/255, alpha: 1)
    static let sideBarIconColor = UIColor(colorLiteralRed: 34/255, green: 34/255, blue: 34/255, alpha: 1)
    
    static let yellowColor = UIColor(colorLiteralRed: 255/255, green: 176/255, blue: 59/255, alpha: 1)
    static let lightBlueColor = UIColor(colorLiteralRed: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    static let darkRedColor = UIColor(colorLiteralRed: 240/255, green: 35/255, blue: 7/255, alpha: 1)
    static let lightGreenColor = UIColor(colorLiteralRed: 70/255, green: 137/255, blue: 102/255, alpha: 1)
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

func appFont(size: CGFloat = AppFont.normalFontSize,fontWeight: FontWeight = .kRegular ) -> UIFont{
    var font = UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
    switch fontWeight {
    case .kRegular:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
        break
    case .kBold:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
        break
    case .kItalic:
        font = UIFont.italicSystemFont(ofSize: size)
        break
    case .kMedium:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightMedium)
        break
    case .kHeavy:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightHeavy)
        break
    case .kSemiBold:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightSemibold)
        break
    case .kLight:
        font = UIFont.systemFont(ofSize: size, weight: UIFontWeightLight)
        break
    }
    return font
}

func appFont1(size: CGFloat = AppFont.normalFontSize,fontWeight: FontWeight = .kRegular ) -> UIFont{
    var font = UIFont(name: AppFont.fontName, size: size)!
    //    switch fontWeight {
    //    case .kRegular:
    //        font = UIFont(name: AppFont.fontName, size: size)!
    //        break
    //    case .kBold:
    //        font = UIFont(name: AppFont.fontName + "-Bold", size: size)!
    //        break
    //    case .kItalic:
    //        font = UIFont(name: AppFont.fontName + "-Italic", size: size)!
    //        break
    //    case .kBoldItalic:
    //        font = UIFont(name: AppFont.fontName + "-Bold Italic", size: size)!
    //        break
    //    case .kMedium:
    //        font = UIFont(name: AppFont.fontName + "-Medium", size: size)!
    //        break
    //    case .kMediumItalic:
    //        font = UIFont(name: AppFont.fontName + "-Medium Italic", size: size)!
    //        break
    //    case .kLight:
    //        font = UIFont(name: AppFont.fontName + "-Light", size: size)!
    //        break
    //    case .kThin:
    //        font = UIFont(name: AppFont.fontName + "-Thin", size: size)!
    //        break
    //    }
    
    font = UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
    
    return font
}

func showAlertView(title: String, message: String, cancelButtonTitle: String = "Ok",view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
    alert.addAction(ok)
    view.present(alert, animated: true, completion: nil)
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

