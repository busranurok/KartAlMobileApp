//
//  WatchVideoViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit


class WatchVideoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        sideMenuVC.toggleMenu()
        
    }
    
}


extension WatchVideoViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchVideoTableViewCell", for: indexPath) as? WatchVideoTableViewCell else {
            fatalError("Unable to create explore table view cell")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    
}

