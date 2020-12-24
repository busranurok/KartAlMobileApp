//
//  ProductsViewController.swift
//  VaktiHazar
//
//  Created by Yeni Kullanıcı on 23.12.2020.
//  Copyright © 2020 Yeni Kullanıcı. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var productImageArray = ["Back","userIcon","watchVideo","phoneIcon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        sideMenuVC.toggleMenu()
        
    }
    

}


extension ProductsViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImageArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as? ProductsCollectionViewCell
        cell?.productImage.image = UIImage(named: productImageArray[indexPath.row])
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BuyVC") as? BuyViewController
        vc?.name = productImageArray[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}


extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width / 2 - 10, height: bounds.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
}
