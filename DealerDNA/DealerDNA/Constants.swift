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

struct Screen {
    
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
