//
//  HomeViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import Foundation
import UIKit
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    let aData : NSArray = ["Hesabım","Video İzle", "Kampanyalar", "Kupon Satın Al", "İletişim Bilgileri", "SSS", "Ayarlar", "Çıkış"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(
            withIdentifier: "kCell", for: indexPath)
        let aLabel : UILabel = aCell.viewWithTag(10) as! UILabel
        aLabel.text = aData[indexPath.row] as? String
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            kConstantObj.SetIntialMainViewController("MyAccountVC") // firstVC is storyboard ID
        }else if indexPath.row == 1 {
            kConstantObj.SetIntialMainViewController("WatchVideoVC")
        }else if indexPath.row == 7 {
            
            let signInController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signInViewController) as? SignInViewController
            
            view.window?.rootViewController = signInController
            view.window?.makeKeyAndVisible()
            
        }
    }
}
