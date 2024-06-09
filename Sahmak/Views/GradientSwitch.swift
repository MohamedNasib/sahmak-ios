//
//  GradientSwitch.swift
//  Sahmak
//
//  Created by Ahmed El-elaimy on 05/06/2023.
//

import UIKit

class GradientSwitch: UISwitch {
    private var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGradientLayer()
    }
    
    private func configureGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [AppColorSystem.primary.color.cgColor, AppColorSystem.secondary.color.cgColor] // Customize the gradient colors as desired
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer?.frame = bounds
        gradientLayer?.cornerRadius = bounds.height / 2
        layer.insertSublayer(gradientLayer!, at: 0)
        
        addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @objc private func switchValueChanged() {
        updateGradientColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    private func updateGradientColor() {
        gradientLayer?.isHidden = !isOn
    }
    
    override var onTintColor: UIColor? {
        didSet {
            // Ignore the provided onTintColor and use the gradient layer instead
            super.onTintColor = UIColor.clear
            updateGradientColor()
        }
    }
}





