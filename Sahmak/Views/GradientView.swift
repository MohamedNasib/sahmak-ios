//
//  GradientView.swift
//  Sahmak
//
//  Created by mac on 25/04/2023.
//

import Foundation
import UIKit

    @IBDesignable
    class GradientView: UIView {

        @IBInspectable var startColor: UIColor = AppColorSystem.primary.color {
            didSet {
                setupView()
                setNeedsLayout()
            }
        }

        @IBInspectable var endColor: UIColor = AppColorSystem.secondary.color {
            didSet {
                setupView()
                setNeedsLayout()
            }
        }
        
        @IBInspectable var isHorizontal: Bool = true {
            didSet{
                setupView()
            }
        }
        
        var gradientLayer = CAGradientLayer()
        
        private func setupView() {
            gradientLayer.frame = bounds
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            if isHorizontal {
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            } else {
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            }
            addGradient()
        }
        
        override public func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
            gradientLayer.frame = bounds
        }
        
        func removeGradient() {
            gradientLayer.removeFromSuperlayer()
        }
        
        func addGradient() {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
