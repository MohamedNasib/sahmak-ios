//
//  categoriesCVC.swift
//  Sahmak
//
//  Created by mac on 23/05/2023.
//

import UIKit

class CategoriesCVC: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    var category: Category? {
        didSet{
            lbl.text = category?.title
            image.image = category?.imgName
        }
    }

}
