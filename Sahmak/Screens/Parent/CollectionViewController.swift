//
//  DraggableViewController.swift
//  Plstka
//
//  Created by FAB LAB on 13/03/2021.
//

import UIKit
import PagedLists

class CollectionViewController: ParentViewController, PagedCollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: PagedCollectionView!
    var array:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.elementsPerPage = pageSize
        collectionView.updateDelegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DealCVC", bundle: nil), forCellWithReuseIdentifier: "DealCVC")
        collectionView.register(UINib(nibName: "TabCVC", bundle: nil), forCellWithReuseIdentifier: "TabCVC")
        collectionView.register(UINib(nibName: "PartnerCVC", bundle: nil), forCellWithReuseIdentifier: "PartnerCVC")
        collectionView.register(UINib(nibName: "VoucherCVC", bundle: nil), forCellWithReuseIdentifier: "VoucherCVC")
        collectionView.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        collectionView.register(UINib(nibName: "ImageCVC", bundle: nil), forCellWithReuseIdentifier: "ImageCVC")
        collectionView.register(UINib(nibName: "MedicalConsultaionCVC", bundle: nil), forCellWithReuseIdentifier: "MedicalConsultaionCVC")
        collectionView.register(UINib(nibName: "CategoriesCVC", bundle: nil), forCellWithReuseIdentifier: "CategoriesCVC")
    }
    
    func reset() {
        array.removeAll()
        collectionView.reloadData()
        collectionView.reset()
    }
    
    func changeTabSelection(tabs:[UIButton], sender: UIButton) {
        for tab in tabs {
            tab.backgroundColor = UIColor.clear
            tab.setTitleColor(UIColor.white, for: .normal)
        }
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.black, for: .normal)
        collectionView.reloadData()
    }
}

extension CollectionViewController {
    
    func collectionView(_ collectionView: PagedCollectionView, needsDataForPage page: Int, completion: (Int, NSError?) -> Void) {
        // Typically request your data over network, update your data source and refresh UI
        completion(collectionView.elementsPerPage, nil)
        // request here
//        searchProducts(for: page)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === collectionView {
            collectionView.scrollViewDidScroll(collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
