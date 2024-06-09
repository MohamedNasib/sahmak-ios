//
//  StepsVC.swift
//  Sahmak
//
//  Created by mac on 05/07/2023.
//

import UIKit

class StepsVC: ParentViewController {

    @IBOutlet weak var viewInterest: UIView!
    @IBOutlet weak var imgInterest: UIImageView!
    @IBOutlet weak var lblInterest: UILabel!
    @IBOutlet weak var lblInterestDescription: UILabel!
    
    @IBOutlet weak var viewFunding: UIView!
    @IBOutlet weak var imgFunding: UIImageView!
    @IBOutlet weak var lblFunding: UILabel!
    @IBOutlet weak var lblFundingDescription: UILabel!
    
    @IBOutlet weak var viewClosing: UIView!
    @IBOutlet weak var imgClosing: UIImageView!
    @IBOutlet weak var lblClosing: UILabel!
    @IBOutlet weak var lblClosingDescription: UILabel!
    
    @IBOutlet weak var imgClosed: UIImageView!
    @IBOutlet weak var lblClosed: UILabel!
    @IBOutlet weak var lblClosedDescription: UILabel!
    
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUI()
    }
    func loadUI(){
        
        switch status {
            case "interest":
            self.setupUI(viewName: viewInterest, lblTitle: lblInterest)
            self.setupImageUI(image: imgInterest, stepsNum: 1)
            break
            case "funding":
            self.setupUI(viewName: viewFunding, lblTitle: lblFunding)
            self.setupImageUI(image: imgFunding, stepsNum: 2)
            break
            case "closing":
            self.setupUI(viewName: viewClosing, lblTitle: lblClosing)
            self.setupImageUI(image: imgClosing, stepsNum: 3)
            break
            case "closed":
            self.lblClosed.textColor = UIColor.black
            self.setupImageUI(image: imgClosed, stepsNum: 4)
            break
        default:
            break
        }
        
    }
    
    func setupUI(viewName: UIView , lblTitle: UILabel){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(hexString: "324C86").withAlphaComponent(0.6).cgColor , UIColor.init(hexString: "35A6DE").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = viewName.bounds
        viewName.layer.insertSublayer(gradientLayer, at: 0)
        lblTitle.textColor = UIColor.black
    }
    
    func setupImageUI(image: UIImageView , stepsNum: Int){
        image.image = UIImage(named: "steps\(stepsNum)_color")
    }
    
}
