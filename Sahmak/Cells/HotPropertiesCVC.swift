//
//  HotPropertiesCVC.swift
//  Sahmak
//
//  Created by mac on 24/05/2023.
//

import UIKit
import Toaster

class HotPropertiesCVC: UICollectionViewCell {
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var imgHeartIcon: UIButton!
    @IBOutlet weak var propertName: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var isSaved = false

    
    var hotProperties: HotPropertiesDetails?{
        didSet{
            self.loadImage(stringUrl: hotProperties?.mainPhoto?.url ?? "", placeHolder: UIImage(named: "Frame"), imgView: self.mainPhoto)
            if K_Defaults.string(forKey: Saved.LANGUAGE) == "ar" {
                propertName.text = hotProperties?.arabicName
                location.text = hotProperties?.arabicLocationName
            }else{
                propertName.text = hotProperties?.englishName
                location.text = hotProperties?.englishLocationName
            }
            if hotProperties?.isSaved == true {
                self.imgHeartIcon.setImage(UIImage(named: "7188636_love_heart_favorite_social_expression_icon"), for: .normal)
            }else{
                self.imgHeartIcon.setImage(UIImage(named: "Frame 196"), for: .normal)
            }
            priceRange.text = "\(hotProperties?.price ?? 0) EGP"
        }
    }
        
    @IBAction func btnSavePressed(_ sender: Any) {
        if hotProperties?.isSaved == false {
            saveProperty(property_id: self.hotProperties?._id ?? "" )
        }else{
            unSaveProperty(property_id: self.hotProperties?._id ?? "")
        }
    }
}

extension HotPropertiesCVC{
    
    func saveProperty(property_id: String){
        K_Network.sendRequest(function: apiService.saveProperty(id: property_id), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                    self.imgHeartIcon.setImage(UIImage(named: "7188636_love_heart_favorite_social_expression_icon"), for: .normal)
                    self.isSaved = true
                }else {
                    Toast(text: response.message).show()
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func unSaveProperty(property_id: String){
        K_Network.sendRequest(function: apiService.unSaveProperty(id: property_id), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                    self.imgHeartIcon.setImage(UIImage(named: "Group 9"), for: .normal)
                    self.isSaved = false
                }else {
                    Toast(text: response.message).show()
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}

