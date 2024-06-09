//
//  FAQCell.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit

class FAQCell: UITableViewCell {

    @IBOutlet weak var lblQustion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var viewAnswer: UIView!
    @IBOutlet weak var viewRow: UIView!
    @IBOutlet weak var viewseperator: UIView!
    
    var isCollapsed: Bool = false {
        didSet {
        }
    }
    
    var faqDataDetails: FAQDataDetails? {
        didSet {
            guard let faqDataDetails = faqDataDetails else { return }
            var language = K_Defaults.string(forKey: Saved.LANGUAGE) ?? ""
            if language == "ar" {
                lblQustion.text = faqDataDetails.arabicQuestion
                lblAnswer.text = faqDataDetails.arabicAnswer
            } else {
                lblQustion.text = faqDataDetails.englishQuestion
                lblAnswer.text = faqDataDetails.englishAnswer
            }
            
            self.lblAnswer.isHidden = faqDataDetails.isCollapsed
            self.viewAnswer.isHidden = faqDataDetails.isCollapsed
            self.viewseperator.isHidden = faqDataDetails.isCollapsed
        }
    }
}
