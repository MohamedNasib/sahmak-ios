//
//  AddCardTVC.swift
//  Sahmak
//
//  Created by mac on 13/04/2023.
//

import UIKit

class AddCardTVC: UITableViewCell {
    
    
    @IBOutlet weak var addCard: UIButton!
    var addCardAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addCard.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func buttonTapped() {
        addCardAction?()
    }
    
    @IBAction func test(_ sender : UIButton){
        print("ay habal")
    }
    
    
}
