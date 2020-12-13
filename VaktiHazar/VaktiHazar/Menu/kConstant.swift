//
//  kConstant.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 11.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import Foundation
import UIKit
let sideMenuVC = KHomeViewController()
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class kConstant {
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func SetIntialMainViewController(_ aStoryBoardID: String)->(KHomeViewController){
        let sideMenuObj = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC")
        let mainVcObj = mainStoryboard.instantiateViewController(withIdentifier: aStoryBoardID)
        let navigationController : UINavigationController = UINavigationController(rootViewController: mainVcObj)
        navigationController.isNavigationBarHidden = true
        sideMenuVC.view.frame = UIScreen.main.bounds
        sideMenuVC.mainViewController(navigationController)
        sideMenuVC.menuViewController(sideMenuObj)
        return sideMenuVC
    }
    func SetMainViewController(_ aStoryBoardID: String)->(KHomeViewController){
        let mainVcObj = mainStoryboard.instantiateViewController(withIdentifier: aStoryBoardID)
        let navigationController : UINavigationController = UINavigationController(rootViewController: mainVcObj)
        navigationController.isNavigationBarHidden = true
        sideMenuVC.view.frame = UIScreen.main.bounds
        sideMenuVC.mainViewController(navigationController)
        return sideMenuVC
    }
    
    // let sideMenuVC = KSideMenuVC()
    
}
