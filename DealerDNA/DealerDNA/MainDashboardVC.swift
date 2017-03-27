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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sendMail()
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
    
}
