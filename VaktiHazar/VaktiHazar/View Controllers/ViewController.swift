//
//  ViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 26.11.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer : AVPlayer?
    var videoPlayerLayer : AVPlayerLayer?
    
    @IBOutlet weak var signUpNowButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Set up video in the background
        setUpVideoPlayer()
        
    }
    
    func setUpElements(){
        
       Utilities.styleFilledButton(signUpNowButton)
       Utilities.styleHollowButton(loginButton)
        
    }
    
    
    func setUpVideoPlayer(){
        
        //Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "login", ofType: "mp4")
        
        guard bundlePath != nil else{
            print("video not found")
            return
        }
        
        
        //Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        
        //Create the video player item
        let item = AVPlayerItem(url: url)
        
        
        //Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        
        //Adjust the size and frame
        //videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
        //
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { [weak self] _ in
            self?.videoPlayer?.seek(to: CMTime.zero)
            self?.videoPlayer?.play()
        
        }
        
    }
    

}

