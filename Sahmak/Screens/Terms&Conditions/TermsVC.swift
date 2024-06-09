//
//  TermsVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import Toaster

class TermsVC: ParentViewController {

    @IBOutlet weak var lblTerms: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        terms()
    }
}


extension TermsVC {
    func terms() {
        K_Network.sendRequest(function: apiService.terms, success: { (code, msg, response)  in
            do {
                let respone = try response.map(to: GetTermsResponse.self, keyPath: "data")
                let isEn = K_Defaults.string(forKey: Saved.LANGUAGE)
                
                if  isEn == "en" {
                    self.lblTerms.text = respone.englishText
                }else{
                    self.lblTerms.text = respone.arabicText
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
