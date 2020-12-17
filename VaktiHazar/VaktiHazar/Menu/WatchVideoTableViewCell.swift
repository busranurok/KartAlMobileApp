//
//  WatchVideoTableViewCell.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 17.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class WatchVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}


extension WatchVideoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VideoDetailVC") as? VideoDetailViewController
        self.parentContainerViewController()?.navigationController?.pushViewController(vc!, animated: true)
        transitionToVideoDetail()
        //self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func transitionToVideoDetail(){
        
        
        let mainVcIntial = kConstantObj.SetIntialMainViewController(Constants.Storyboard.videoDetailViewController)
        self.parentContainerViewController()?.view.window?.rootViewController = mainVcIntial
        
        /*let myAccountViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.myAccountViewController) as? MyAccountViewController
         
         view.window?.rootViewController = myAccountViewController*/
         self.parentContainerViewController()?.view.window?.makeKeyAndVisible()
        
        
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let videoDetailVc = storyboard.instantiateViewController(withIdentifier: ) as? VideoDetailViewController
        self.parentContainerViewController()?.view.window?.rootViewController = videoDetailVc
        self.parentContainerViewController()?.view.window?.makeKeyAndVisible()*/
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 102, height: 92)
        
    }
    
}
