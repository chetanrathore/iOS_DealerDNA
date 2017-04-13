//
//  CustomNavigationBar.swift
//  DealerDNA
//
//  Created by LaNet on 3/24/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

enum LeftButton{
    case menu, back, noBack
}

@objc protocol CustomNevigationDeletegate {
    @objc optional func btnLeftClick()
    @objc optional func btnRightClick()
}

class CustomNavigationBar: UIViewController {
    
    var delegate: CustomNevigationDeletegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createView(_ superView: UIView,title: String, backBtn: LeftButton, isRightRequired: Bool = false, rightBtnTitle: String?, rightButtonImage: UIImage?){
        
        Screen.screenWidth = UIScreen.main.bounds.width
        Screen.screenHeight = UIScreen.main.bounds.height
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen.screenWidth, height: 64))
        view.backgroundColor = AppColor.theamColor
        view.tag = 3434
        view.autoresizingMask = .flexibleWidth
        let backButton = UIButton()
        switch backBtn {
        case .back:
            backButton.frame = CGRect(x: 10, y: 25, width: 30, height: 30)
            backButton.setImage(UIImage(named: "left.png"), for: .normal)
            view.addSubview(backButton)
            break
        case .noBack:
            break
        case .menu:
            backButton.frame = CGRect(x: 12, y: 27, width: 28, height: 30)
            backButton.setImage(#imageLiteral(resourceName: "sidemenuicon"), for: .normal)
            view.addSubview(backButton)
            break
        }
        
        if backBtn == .menu || backBtn == .back{
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 60, height: 64)
            btn.addTarget(self, action: #selector(btnLeftClick), for: .touchUpInside)
            view.addSubview(btn)
            
        }
        
        let label = UILabel(frame: CGRect(x: 40, y: 25, width: Screen.screenWidth - 80, height: 30))
        label.font = appFont(size: AppFont.titleFontSize)
        label.textColor = UIColor.white
        label.text = title
        label.textAlignment = .center
        view.addSubview(label)
        
        if isRightRequired{
            if rightBtnTitle != nil{
                let backButton = UIButton()
                backButton.frame = CGRect(x: Screen.screenWidth - 50, y: 25, width: 50, height: 30)
                backButton.setTitle(rightBtnTitle!, for: .normal)
                backButton.addTarget(self, action: #selector(btnRightClick), for: .touchUpInside)
                view.addSubview(backButton)
            }else if rightButtonImage != nil{
                let backButton = UIButton()
                backButton.frame = CGRect(x: 5, y: 25, width: 30, height: 30)
                backButton.setImage(UIImage(named: "menu.png"), for: .normal)
                backButton.addTarget(self, action: #selector(btnRightClick), for: .touchUpInside)
                view.addSubview(backButton)
            }
        }
        
        superView.addSubview(view)
    }
    
    func btnLeftClick(){
        delegate?.btnLeftClick!()
    }
    
    func btnRightClick(){
        delegate?.btnRightClick!()
    }
    
}
