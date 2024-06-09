//
//  DashboardVC.swift
//  Sahmak
//
//  Created by mac on 07/05/2023.
//

import UIKit
import PieCharts

class DashboardVC: ParentViewController {

    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        add()
        
    }
    
    func add (){
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        textLayerSettings.label.textColor = UIColor.white

        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }

        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
     
        chartView.layers = [textLayer]
        chartView.models = [
            PieSliceModel(value: 1, color: UIColor(hexString: "#165BAA")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#1DDD8D")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#F765A3")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#A155B9")),
        ]

        
    }
    
    

    @IBAction func btnpressed(_ sender: Any) {
        let viewLayer = PieCustomViewsLayer()

        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 135
        settings.hideOnOverflow = false
        viewLayer.settings = settings

        viewLayer.viewGenerator = {slice, center in
            let myView = UIView()
            // add images, animations, etc.
            return myView
        }
    }
    

}
