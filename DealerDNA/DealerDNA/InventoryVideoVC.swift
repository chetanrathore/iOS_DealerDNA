//
//  InventoryVideoVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer


class InventoryVideoVC: UIViewController {
    
    @IBOutlet var vwVideo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSelectAndPlay(_ sender: UIButton) {
                self.startMediaBrowserFromViewController(viewController: self, usingDelegate: self)
    }
    
    
    @IBAction func handlePlayVideoFromUrl(_ sender: UIButton) {
        loadVideo()
    }
    
    func loadVideo(){
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
//        playerViewController.view.frame = CGRect(x: 0, y: 200, width: 375, height: 375)//self.vwVideo.frame
        
//        self.vwVideo.addSubview(playerViewController.view)
        
        self.present(playerViewController, animated: true) {
            if #available(iOS 10.0, *) {
                playerViewController.player?.automaticallyWaitsToMinimizeStalling = true
            } else {
                // Fallback on earlier versions
            }
            playerViewController.player!.play()
        }
        
        //        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        //        let player = AVPlayer(url: videoURL!)
        //        let playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = self.view.bounds
        //        self.view.layer.addSublayer(playerLayer)
        //        player.play()
    }
    
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: UINavigationControllerDelegate & UIImagePickerControllerDelegate) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            return false
        }
        
        // 2
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .savedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        
        present(mediaUI, animated: true, completion: nil)
        return true
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension InventoryVideoVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        dismiss(animated: true, completion: nil)
        
//        if mediaType == kUTTypeMovie{
//            
//            let player = AVPlayer(url: info[UIImagePickerControllerMediaURL] as! URL!)
//            let playerVC = AVPlayerViewController()
//            playerVC.player = player
//            
//            self.present(playerVC, animated: true, completion: { 
//                playerVC.player?.play()
//                
//            })
        
        let videoURL = info[UIImagePickerControllerMediaURL] as! URL!
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        
        self.present(playerViewController, animated: true) {
            if #available(iOS 10.0, *) {
                playerViewController.player?.automaticallyWaitsToMinimizeStalling = true
            } else {
                // Fallback on earlier versions
            }
            playerViewController.player!.play()
      
        
            
//            let moviePlayer = MPMoviePlayerViewController(contentURL: info[UIImagePickerControllerMediaURL] as! URL!)
//            self.present(moviePlayer!, animated: true, completion: nil)
        }
        
        
        
    }
    
}

// MARK: - UINavigationControllerDelegate
extension InventoryVideoVC: UINavigationControllerDelegate {
}
