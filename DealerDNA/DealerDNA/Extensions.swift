//
//  Extensions.swift
//  DealerDNA
//
//  Created by LaNet on 3/22/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func isEmpty()->Bool{
        let trimmedString = self.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if trimmedString!.characters.count == 0
        {
            return true
        }
        return false
    }
    
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

extension UINavigationController{
    
    func isContain(view: UIViewController){
        let viewControllers = self.viewControllers as Array
        self.viewControllers = viewControllers.filter{ views in
            if views.isKind(of: view.classForCoder){
                return false
            }
            return true
        }
    }
}

extension UIImageView{
    
    func setTintColor(color: UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
