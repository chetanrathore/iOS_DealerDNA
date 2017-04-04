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
        setLayout()
        setSlidetImages()
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
        }
        scrollVWImage.contentSize = CGSize(width: self.totalImages * Int(Screen.screenWidth), height: Int(scrollVWImage.bounds.height))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.slider), userInfo: nil, repeats: true)
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
    
}
