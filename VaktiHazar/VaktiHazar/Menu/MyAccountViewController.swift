//
//  MyAccountViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//
import Foundation
import UIKit

class MyAccountViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sideMenuTapped(_ sender: Any) {
        
        sideMenuVC.toggleMenu()
        
    }

}
