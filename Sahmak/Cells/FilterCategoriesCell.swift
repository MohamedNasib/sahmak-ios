//
//  FilterCategoriesCell.swift
//  Sahmak
//
//  Created by mac on 08/07/2023.
//

import UIKit

class FilterCategoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCategoryTitle: UILabel!

    var category: CattegoriesDetails?{
        
        didSet{
            let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
            
            if isAr {
                self.lblCategoryTitle.text = category?.arabicName
            }else {
                self.lblCategoryTitle.text = category?.englishName
            }
        }
    }

}
