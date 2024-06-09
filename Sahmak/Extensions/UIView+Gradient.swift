//
//  UIView+Gradient.swift
//  Sahmak
//
//  Created by Ahmed El-elaimy on 30/05/2023.
//

import UIKit

extension UIView{
    func addGradientBackground() {
        let colors = [AppColorSystem.primary.color, AppColorSystem.secondary.color]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientBackground() {
        
        self.layer.removeFromSuperlayer()
    }
    
}
