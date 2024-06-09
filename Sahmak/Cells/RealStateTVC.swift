//
//  RealStateTVC.swift
//  Sahmak
//
//  Created by mac on 01/05/2023.
//

import UIKit
import Toaster

class RealStateTVC: UITableViewCell {

    @IBOutlet weak var imgMainPhoto: UIImageView!
    @IBOutlet weak var imgHeartIcon: UIButton!
    @IBOutlet weak var lblPriceRange: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    var isSaved = false
    
    var hotProperty: HotPropertiesDetails?{
        didSet{
            self.loadImage(stringUrl: hotProperty?.property?.mainPhoto?.url ?? "", placeHolder: UIImage(named: "Frame"), imgView: self.imgMainPhoto)
            self.imgHeartIcon.setImage(UIImage(named:"Group 9"), for: .normal)
            self.lblPriceRange.text = "\(hotProperty?.minPrice ?? 0) EGP - \(hotProperty?.maxPrice ?? 0) EGP"
            if K_Defaults.string(forKey: Saved.LANGUAGE) == "ar" {
                lblName.text = hotProperty?.arabicName
                lblLocation.text = hotProperty?.arabicLocationName
            }else{
                lblName.text = hotProperty?.englishName
                lblLocation.text = hotProperty?.englishLocationName
            }
        }
    }
    
    var property: HotPropertiesDetails?{
        didSet{
            self.loadImage(stringUrl: property?.property?.mainPhoto?.url ?? "", placeHolder: UIImage(named: "Frame"), imgView: self.imgMainPhoto)
            self.imgHeartIcon.setImage(UIImage(named:"Group 9"), for: .normal)
            self.lblPriceRange.text = "\(property?.property?.minPrice ?? 0) EGP - \(property?.property?.maxPrice ?? 0) EGP"
            if K_Defaults.string(forKey: Saved.LANGUAGE) == "ar" {
                lblName.text = property?.property?.arabicName
                lblLocation.text = property?.property?.arabicLocationName
            }else{
                lblName.text = property?.property?.englishName
                lblLocation.text = property?.property?.englishLocationName
            }
        }
    }
    
    
    @IBAction func btnSavePressed(_ sender: Any) {
        if hotProperty != nil {
            if isSaved == false {
                saveProperty(property_id: self.property?._id ?? "" )
            }else{
                unSaveProperty(property_id: self.property?._id ?? "")
            }
        }else{
            if isSaved == false {
                saveProperty(property_id: self.property?._id ?? "" )
            }else{
                unSaveProperty(property_id: self.property?._id ?? "")
            }
        }
    }
    
    
}



extension RealStateTVC{
    
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
