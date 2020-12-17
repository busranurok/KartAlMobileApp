//
//  VideoDetailViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 17.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit
import AVFoundation

class VideoDetailViewController: UIViewController {

    var playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo()

    }
    
    func playVideo() {
        let videoURL =  URL(string: "http://techslides.com/demos/sample-videos/small.mp4")!
        let player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        playerLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        
        let  watchViedoViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.watchVideoViewController) as? WatchVideoViewController
        
        view.window?.rootViewController =  watchViedoViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
