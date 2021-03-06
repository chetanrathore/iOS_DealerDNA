//
//  InventoryDetailVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryDetailVC: UIViewController, CustomNevigationDeletegate, UIScrollViewDelegate {
    
    let customNav = CustomNavigationBar()
    @IBOutlet var scrollVWImage: UIScrollView!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var vwDetailHeight: NSLayoutConstraint!
    
    @IBOutlet var vwHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollViewTop: NSLayoutConstraint!
    
    @IBOutlet var btnCloseSlide: UIButton!
    
    var isSlideed = false
    let totalImages = 5
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        setLayout()
        setSlidetImages()
    }
    
    override func viewDidLayoutSubviews() {
        if self.view.viewWithTag(3434) == nil{
            if !self.isSlideed{ setLayout()}
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        
    }
    
    func setLayout(){
        customNav.delegate = self
        customNav.createView(self.view, title: "Inventory detail", backBtn: .back, isRightRequired: false, rightBtnTitle: nil, rightButtonImage: nil)
        
    }
    
    func btnLeftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Image slider
    
    func setSlidetImages(){
        for i in 0..<totalImages{
            let imageView = UIImageView()
            imageView.frame = CGRect(x: i * Int(Screen.screenWidth), y: 0, width: Int(Screen.screenWidth), height: Int(scrollVWImage.bounds.height))
            imageView.image = UIImage(named: "bike1.jpg")
            imageView.contentMode = .scaleAspectFit
            scrollVWImage.addSubview(imageView)
            imageView.tag = i
            imageView.autoresizingMask = [.flexibleHeight]
        }
        scrollVWImage.contentSize = CGSize(width: self.totalImages * Int(Screen.screenWidth), height: Int(scrollVWImage.bounds.height))
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.slider), userInfo: nil, repeats: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.changeScrollViewSize))
        scrollVWImage.addGestureRecognizer(tapGesture)
        
    }
    
    func slider() {
        let x = self.scrollVWImage.bounds.origin.x
        let width = self.scrollVWImage.contentSize.width
        if x+Screen.screenWidth == width{
            let point = CGPoint(x: 0, y: self.scrollVWImage.bounds.origin.y)
            self.scrollVWImage.setContentOffset(point, animated: false)
        }else{
            let point = CGPoint(x: x + Screen.screenWidth, y: self.scrollVWImage.bounds.origin.y)
            self.scrollVWImage.setContentOffset(point, animated: true)
        }
    }
    
    func changeScrollViewSize(_ sender: UITapGestureRecognizer){
        self.isSlideed = true
        
        let window = UIApplication.shared.keyWindow
        window?.windowLevel = UIWindowLevelStatusBar + 1
        
        
        if self.view.viewWithTag(3434) != nil{
            self.view.viewWithTag(3434)!.removeFromSuperview()
        }
        self.mainScrollView.isScrollEnabled = false
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.vwDetailHeight.constant = 0
            self.vwHeight.constant = UIScreen.main.bounds.height
            self.scrollViewTop.constant = 0
            self.view.layoutIfNeeded()
        }
        
        //        let vc = InventoryImageVC(nibName: "InventoryImageVC", bundle: nil)
        //        //vc.img.image =  UIImage(named: "bike1.jpg")
        //        self.present(vc, animated: true, completion: nil)
        //self.scrollVWImage.contentOffset.x / self.scrollVWImage.frame.width
        //        self.view.layer.layoutIfNeeded()
        //        UIView.animate(withDuration: 0.3) {
        //            self.navTopSpace.constant = 0
        //            self.scrollViewHeight.constant = Screen.screenHeight
        //            self.view.layer.layoutIfNeeded()
        //        }
    }
    
    @IBAction func btnCloseSlide(_ sender: UIButton) {
        self.isSlideed = false
        self.mainScrollView.isScrollEnabled = true
        
        let window = UIApplication.shared.keyWindow
        window?.windowLevel = UIWindowLevelNormal
        
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.vwDetailHeight.constant = 227
            self.vwHeight.constant = 463
            self.scrollViewTop.constant = 64
            self.view.layoutIfNeeded()
        }
        
    }
    
}
