//
//  WatchVideoViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit
class WatchVideoViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        sideMenuVC.toggleMenu()
        
    }
    
}
