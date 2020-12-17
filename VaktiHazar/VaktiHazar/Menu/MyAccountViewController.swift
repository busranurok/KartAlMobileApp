//
//  MyAccountViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//
import Foundation
import UIKit

class MyAccountViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
     let categoryData : NSArray = ["Kişisel Bilgilerim","E-posta Adresimi Değiştir", "Şifremi Değiştir", "Adresimi Değiştir", "Kuponlarım", "Siparişlerim"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(
            withIdentifier: "kCell", for: indexPath)
        let aLabel : UILabel = aCell.viewWithTag(1) as! UILabel
        aLabel.text = categoryData[indexPath.row] as? String
        return aCell
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        
    }
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            kConstantObj.SetIntialMainViewController("PersonelInformationVC") // firstVC is storyboard ID
            
        }else if indexPath.row == 1 {
            
            kConstantObj.SetIntialMainViewController("ChangeMailVC")
            
        }else if indexPath.row == 2 {
            
            kConstantObj.SetIntialMainViewController("ChangePasswordVC")
            
        }else if indexPath.row == 3 {
            
            kConstantObj.SetIntialMainViewController("ChangeAddressVC")
            
        }
        
    }

    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func sideMenuTapped(_ sender: Any) {
        
        sideMenuVC.toggleMenu()
        
    }
    @IBAction func exitButtonTapped(_ sender: Any) {
        
        let signInController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signInViewController) as? SignInViewController
        
        view.window?.rootViewController = signInController
        view.window?.makeKeyAndVisible()
        
    }
    
}
