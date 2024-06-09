//
//  LineChartViewController.swift
//  Sahmak
//
//  Created by mac on 27/07/2023.
//

import Foundation
import UIKit
import Charts

class LineChartViewController: LineChartView {

    override func awakeFromNib() {
        super.awakeFromNib()

        // Customization options (optional)
        self.backgroundColor = UIColor.white
        self.noDataText = "No data available"
        self.animate(xAxisDuration: 0.3)
        // Add more customization options as per your requirements
    }

    func setData(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let dataSet = LineChartDataSet(entries: dataEntries, label: "Line Chart")
        
        
        
        
        
        dataSet.colors = [UIColor(hexString: "#23B371")] // Customize line color
        dataSet.circleColors = [UIColor(hexString: "#23B371")] // Customize circle color
        dataSet.circleHoleColor = UIColor.white // Customize circle center color
        dataSet.lineWidth = 3
        dataSet.drawFilledEnabled = true
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.fill = ColorFill(color: UIColor(hexString: "#23B371"))
        dataSet.fillAlpha = 0.4
        dataSet.drawFilledEnabled = true
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        dataSet.drawIconsEnabled = false
        let gradientColors = [UIColor(hexString: "#23B371").cgColor, UIColor(hexString: "#FFFFFF").cgColor] as CFArray
                let gradient = CGGradient(colorsSpace: nil, colors: gradientColors, locations: nil)
                dataSet.fill = LinearGradientFill(gradient: gradient!, angle: 270.0)
        let data = LineChartData(dataSet: dataSet)

        self.data = data
    }
}
