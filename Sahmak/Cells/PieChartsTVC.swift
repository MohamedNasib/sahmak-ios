//
//  PieChartsTVC.swift
//  Sahmak
//
//  Created by mac on 23/05/2023.
//

import UIKit
import PieCharts

class PieChartsTVC: UITableViewCell {

    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var lblTotalBalance: UILabel!
    @IBOutlet weak var lblprofitAmount: UILabel!
    @IBOutlet weak var imgPercent: UIImageView!

    
    @IBOutlet weak var chartView: PieChart!
    

    func configurPieChartsTVC(totalBalance: TotalBalanceDetails?){
        self.lblPercent.text = "\(totalBalance?.profitPrecentage ?? 0)%"
        self.lblTotalBalance.text = "\(totalBalance?.totalInvestedBalance ?? 0) EGP"
        self.lblprofitAmount.text = "+ \(totalBalance?.profitAmount ?? 0) EGP"
        pieChartsModel()
    }
    
    func pieChartsModel (){
            chartView.models = [
            PieSliceModel(value: 1, color: UIColor(hexString: "#165BAA")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#1DDD8D")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#F765A3")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#16BFD6")),
            PieSliceModel(value: 1, color: UIColor(hexString: "#A155B9")),
        ]
    }
    
}


