//
//  LanguageVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import MOLH

class LanguageVC: ParentViewController {
    
    @IBOutlet weak var lblArabic: UILabel!
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var arabicIconChosed: UIButton!

    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var englishIconChosed: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        onViewsClick()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        languageViewDesign()
    }
    
    func languageViewDesign(){
        if K_Defaults.string(forKey: Saved.LANGUAGE) == "en" {
            englishView.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
            englishView.layer.borderColor = UIColor(named: "Primary")?.cgColor
            englishIconChosed.isHidden = false
        } else {
            arabicView.backgroundColor = UIColor(named: "Primary")?.withAlphaComponent(0.2)
            arabicView.layer.borderColor = UIColor(named: "Primary")?.cgColor
            arabicIconChosed.isHidden = false
        }
    }
    
    func onViewsClick() {
        arabicView.onTap(action: {
            self.changeLanguage(language: "ar")
        })
        englishView.onTap(action: {
            self.changeLanguage(language: "en")
        })
    }
    
    func changeLanguage(language: String) {
        K_Defaults.set(language, forKey: Saved.LANGUAGE)
        MOLH.setLanguageTo(language)
        MOLH.reset()
    }
}
