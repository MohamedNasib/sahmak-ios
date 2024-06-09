//
//  LineChartTest.swift
//  Sahmak
//
//  Created by mac on 27/07/2023.
//

import UIKit

class LineChartTest: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sample data for the line chart
        let dataPoints = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let values = [10.0, 20.0, 2.0, 25.0, 1.0, 12.0]
        lineChartView.setData(dataPoints: dataPoints, values: values)
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.enabled = false
        // Hide the left Y-axis and its labels
        lineChartView.leftAxis.enabled = false
        // Hide the right Y-axis and its labels
        lineChartView.rightAxis.enabled = false
        
        
    }
}
