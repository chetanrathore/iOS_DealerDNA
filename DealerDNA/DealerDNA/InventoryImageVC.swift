//
//  InventoryImageVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/3/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class InventoryImageVC: UIViewController {
    
    @IBOutlet var img: UIImageView!
    var imageFrame: CGRect!
    var swipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        img.frame = self.imageFrame
        //
        //        UIView.animate(withDuration: 0.3, animations: {
        //            self.img.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-64)
        //        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        
        //        let openGLContext = EAGLContext(api: .openGLES2)
        //        let context = CIContext(eaglContext: openGLContext!)
        //
        //        guard let image = self.img.image, let cgimage = image.cgImage else {
        //            return
        //        }
        //        let coreImage = CIImage(cgImage: cgimage)
        //        let filter = CIFilter(name: "CISepiaTone")
        //        filter?.setValue(coreImage, forKeyPath: kCIInputImageKey)
        //        filter?.setValue(1, forKeyPath: kCIInputIntensityKey)
        //
        //        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage{
        //            let cgimager = context.createCGImage(output, from: output.extent)
        //            let result = UIImage(cgImage: cgimager!)
        //            self.img.image = result
        //        }
        //
        //        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        //        button.setTitle("Done", for: .normal)
        //        button.addTarget(self, action: #selector(self.handleDone), for: .touchUpInside)
        //        button.setTitleColor(UIColor.black, for: .normal)
        //        let navBtn = UIBarButtonItem(customView: button)
        //
        //        self.navigationItem.setRightBarButton(navBtn, animated: true)
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        UIView.animate(withDuration: 1, delay: 0.5, options: [.autoreverse,], animations: {
        //            self.img.bounds = CGRect(x: 10, y: self.img.frame.origin.y + 10, width: self.img.frame.width - 10, height: self.img.frame.height - 10)
        //
        //        }) { (complete) in
        //
        //        }
    }
    
    func handleDone(){
        
        //        UIView.animate(withDuration: 0.4, animations: {
        //            self.img.frame = self.imageFrame
        //            self.navigationController?.navigationBar.isHidden = true
        //        }) { (complete) in
        //            self.navigationController?.popViewController(animated: false)
        //        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loc = touches.first?.location(in: self.view)
        self.img.center = loc!
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleDone()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
