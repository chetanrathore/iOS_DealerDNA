//
//  MainDashboardVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/24/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import MessageUI

class MainDashboardVC: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var vwTopConstrain: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    var timer: Timer!
    let count = 5
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for i in 0..<count{
            let imageView = UIImageView()
            imageView.frame = CGRect(x: i * Int(Screen.screenWidth), y: 0, width: Int(Screen.screenWidth), height: 320)
            imageView.image = UIImage(named: "bike1.jpg")
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            
        }
        scrollView.contentSize = CGSize(width: count * Int(Screen.screenWidth), height: 320)
        //        sendMail()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.slider), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLayoutSubviews() {
//        self.vwTopConstrain.constant = -300
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func slider() {
        let x = self.scrollView.bounds.origin.x
        let width = self.scrollView.contentSize.width
        if x+Screen.screenWidth == width{
            let point = CGPoint(x: 0, y: self.scrollView.bounds.origin.y)
            self.scrollView.setContentOffset(point, animated: false)
        }else{
            let point = CGPoint(x: x + Screen.screenWidth, y: self.scrollView.bounds.origin.y)
            self.scrollView.setContentOffset(point, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print("Here")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.delegate = self
            mailComposeVC.addAttachmentData(UIImagePNGRepresentation(UIImage(named: "email.png")!)!, mimeType: "image/png", fileName: "img.png")
            //            mailComposeVC.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "bike1.jpg")!, 1.0)!, mimeType: "image/jpeg", fileName: "myimg.jpg")
            //  mailComposeVC.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "bike2.jpg")!, 1.0)!, mimeType: "image/jpeg", fileName: "myimg.jpg")
            mailComposeVC.setToRecipients(["chetan.rathore.dev@gmail.com"])
            mailComposeVC.setSubject("VIEW IN FOCUS")
            let strHtml = "<b>Test mail</b>"
            mailComposeVC.setMessageBody(strHtml, isHTML: true)
            self.present(mailComposeVC, animated: true, completion: nil)
        }else{
            print("Please add gmail account, for send mail.")
        }
    }
    
    func sendMessage() {
        
    }
    
    @IBAction func btnDisplayVW(_ sender: UIButton) {
        
        self.view.layoutIfNeeded()
        if self.vwTopConstrain.constant > 0{
        UIView.animate(withDuration: 0.5) {
            self.vwTopConstrain.constant = -300
            self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.vwTopConstrain.constant = 300
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
}
