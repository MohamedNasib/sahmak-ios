//
//  YourPropertiesCVC.swift
//  Sahmak
//
//  Created by mac on 24/05/2023.
//

import UIKit
import OnlyPictures

class YourPropertiesCVC: UICollectionViewCell {

    @IBOutlet weak var imgMainPhoto: UIImageView!
    @IBOutlet weak var lblYourPropertName: UILabel!
    @IBOutlet weak var lblYorPropertLocation: UILabel!
    @IBOutlet weak var onlyPictures: OnlyHorizontalPictures!
    @IBOutlet weak var lblTotalInvestedBalance: UILabel!
    @IBOutlet weak var lblBalancePercent: UILabel!
    @IBOutlet weak var imgBalancePercent: UIImageView!

    var youPropert: YourPropertiesDetails?{
        didSet{
            self.loadImage(stringUrl: youPropert?.mainPhoto?.url ?? "", placeHolder: UIImage(named: "Frame"), imgView: self.imgMainPhoto)
            self.lblTotalInvestedBalance.text = "\(youPropert?.totalInvestedBalance ?? 0)EGP"

            if K_Defaults.string(forKey: Saved.LANGUAGE) == "ar" {
                self.lblYourPropertName.text = youPropert?.arabicName
                self.lblYorPropertLocation.text = youPropert?.arabicLocationName
            }
            else{
                self.lblYourPropertName.text = youPropert?.englishName
                self.lblYorPropertLocation.text = youPropert?.englishLocationName
            }
        }
    }
}
