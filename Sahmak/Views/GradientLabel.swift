//
//  GradientLabel.swift
//  Sahmak
//
//  Created by mac on 16/04/2023.
//

import Foundation
import UIKit

@IBDesignable
class GradientLabel: UILabel {

    @IBInspectable var startColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) {
        didSet { setNeedsLayout() }
    }

    @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) {
        didSet { setNeedsLayout() }
    }

    // 0 -> from top to bottom
    // 1 -> from right to left
    // 2 -> from bottom to top
    // 3 -> from left to right
    @IBInspectable var direction: Int = 0 {
        didSet { setNeedsLayout() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateTextColor()
    }

    private func updateTextColor() {
        let image = UIGraphicsImageRenderer(bounds: bounds).image { context in
        var startPoint = CGPoint(x: bounds.midX, y: bounds.minY)
        var endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
            switch direction {
            case 1:
                startPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                endPoint = CGPoint(x: bounds.minX, y: bounds.midY)
            case 2:
                startPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
                endPoint = CGPoint(x: bounds.midX, y: bounds.minY)
            case 3:
                startPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                endPoint = CGPoint(x: bounds.minX, y: bounds.midY)
            default:
                break
            }
            
            
            
            let colors = [startColor.cgColor, endColor.cgColor]
            guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil) else { return }
            context.cgContext.drawLinearGradient(gradient,
                                                 start: CGPoint(x: bounds.midX, y: bounds.minY),
                                                 end: CGPoint(x: bounds.midX, y: bounds.maxY),
                                                 options: [])
        }

        textColor = UIColor(patternImage: image)
    }

}
