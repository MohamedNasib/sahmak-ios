//
//  YourPropertiesTVC.swift
//  Sahmak
//
//  Created by mac on 24/05/2023.
//

import UIKit

class YourPropertiesTVC: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var yourPropertiesCollectionView: UICollectionView!
    var yourPropertiesArray: [YourPropertiesDetails]?
    
    func yourPropertiesCellConfigur(yourPropertiesArray: [YourPropertiesDetails]){
        yourPropertiesCollectionView.dataSource = self
        yourPropertiesCollectionView.delegate = self
        yourPropertiesCollectionView.register(UINib(nibName: "YourPropertiesCVC", bundle: nil), forCellWithReuseIdentifier: "YourPropertiesCVC")
        self.yourPropertiesArray = yourPropertiesArray
        yourPropertiesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yourPropertiesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourPropertiesCVC", for: indexPath) as! YourPropertiesCVC
        cell.youPropert = yourPropertiesArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: 343, height: 89)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
    
}
