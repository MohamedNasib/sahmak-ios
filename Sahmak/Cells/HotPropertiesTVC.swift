//
//  HotPropertiesTVC.swift
//  Sahmak
//
//  Created by mac on 24/05/2023.
//

import UIKit

class HotPropertiesTVC: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var hotPropertiesCollectionView: UICollectionView!
    @IBOutlet weak var lblViewAll: UILabel!
    var hotPropertiesArray: [HotPropertiesDetails]?
    var context: HomeVC?

    func hotPropertiesCellConfigur(hotPropertiesArray: [HotPropertiesDetails]){
        hotPropertiesCollectionView.dataSource = self
        hotPropertiesCollectionView.delegate = self
        hotPropertiesCollectionView.register(UINib(nibName: "HotPropertiesCVC", bundle: nil), forCellWithReuseIdentifier: "HotPropertiesCVC")
        self.hotPropertiesArray = hotPropertiesArray
        hotPropertiesCollectionView.reloadData()
        
        self.lblViewAll.onTap(action: {
            self.onViewAllPressed()
        })
    }
    
    func onViewAllPressed(){
        let vc = SearchVC.loadFromNib()
        vc.array = self.hotPropertiesArray ?? []
        vc.modalPresentationStyle = .fullScreen
        context?.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotPropertiesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotPropertiesCVC", for: indexPath) as! HotPropertiesCVC
        cell.hotProperties = hotPropertiesArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HotPropertyDetailsVC.loadFromNib()
        vc.property_id = hotPropertiesArray?[indexPath.row]._id ?? ""
        vc.modalPresentationStyle = .fullScreen
        context?.present(vc, animated: true)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: 327, height: 229)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
    
}
