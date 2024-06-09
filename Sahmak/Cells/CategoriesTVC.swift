//
//  CategoriesTVC.swift
//  Sahmak
//
//  Created by mac on 23/05/2023.
//

import UIKit

class CategoriesTVC: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var arrayOfCatigories: [Category] = []
    
    func categoryCellRegister(){
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: "CategoriesCVC", bundle: nil), forCellWithReuseIdentifier: "CategoriesCVC")
        arrayOfCatigories.append(Category(title:"funds".localized(), imgName: UIImage(named: "House")!))
        arrayOfCatigories.append(Category(title:"apartments".localized(), imgName: UIImage(named: "apartment")!))
        arrayOfCatigories.append(Category(title:"villa".localized(), imgName: UIImage(named: "Tiny home")!))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVC", for: indexPath) as! CategoriesCVC
        cell.category = arrayOfCatigories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0 :
            print("funds")
            break
        case 1 :
            print("apartments")
            break
        case 2 :
            print("villa")
            break
            
        default:
            break
        }
    }
   
    
}

struct Category {
    var title: String
    var imgName: UIImage
    
    init(title: String, imgName: UIImage) {
        self.title = title
        self.imgName = imgName
    }
}


