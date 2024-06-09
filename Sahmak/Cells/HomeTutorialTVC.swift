//
//  HomeTutorialTVC.swift
//  Sahmak
//
//  Created by mac on 23/05/2023.
//

import UIKit

class HomeTutorialTVC: UITableViewCell {

    @IBOutlet weak var btnShowTutorial: UIButton!
    @IBOutlet weak var btnSkipTutorial: UIButton!

    
    func configurHomeTutorialTVC(){
        setSkipTutorialUnderLine()
    }
    
    func setSkipTutorialUnderLine(){
        let yourAttributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 12),
             .foregroundColor: UIColor.white,
             .underlineStyle: NSUnderlineStyle.single.rawValue
         ]
        let attributeString = NSMutableAttributedString(
            string: "skip tutorial".localized(), attributes: yourAttributes
             )
        btnSkipTutorial.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func btnShowTutorialPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Tutorial")
        vc.modalPresentationStyle = .fullScreen
        parentViewController?.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSkipTutorialPressed(_ sender: UIButton) {
        K_Defaults.set(true, forKey: Saved.TUTORIAL_SKIPPED)
        (parentViewController as? HomeVC)?.tableView.reloadData()
    }
}
