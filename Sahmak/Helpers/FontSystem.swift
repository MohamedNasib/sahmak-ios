//
//  FontSystem.swift
//
//  Created by hassan on 11/9/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit


private let enFamilyName = "Poppins"
private let arFamilyName = "Cairo"

enum AppFontSystem: String {
    
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case black = "Black"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size ) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }

    fileprivate var fullFontName: String {
        let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
        if isAr {
            if let font = CairoFontSystem.init(rawValue: self.rawValue){
                return font.fullFontName
            }
            return CairoFontSystem.regular.fullFontName
        } else {
            if let font = PoppinsFontSystem.init(rawValue: self.rawValue) {
                return font.fullFontName
            }
            return PoppinsFontSystem.regular.fullFontName
        }
    }

}

enum CairoFontSystem: String {
    
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case black = "Black"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size ){//+ 1.0) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? arFamilyName : arFamilyName + "-" + rawValue
    }

}

fileprivate enum PoppinsFontSystem: String {
    
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case black = "Black"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size ){
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    fileprivate var fullFontName: String {
        let ss = rawValue.isEmpty ? enFamilyName : enFamilyName + "-" + rawValue
        return ss
    }

}


// MARK: - Localizing Font For UIViews
extension UILabel {
    
    @IBInspectable
    var extraBold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.extraBold.size(newValue)
        }
    }
    
    @IBInspectable
    var extraLight: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.extraLight.size(newValue)
        }
    }
    
    @IBInspectable
    var semiBold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.semiBold.size(newValue)
        }
    }
    
    @IBInspectable
    var medium: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.medium.size(newValue)
        }
    }
    
    @IBInspectable
    var regular: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.regular.size(newValue)
        }
    }
    
    @IBInspectable
    var light: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.light.size(newValue)
        }
    }
    
    @IBInspectable
    var black: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.black.size(newValue)
        }
    }
    
    @IBInspectable
    var bold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.bold.size(newValue)
        }
    }
    
    fileprivate var fontSize: CGFloat {
        return font.pointSize
    }
}
extension UITextField {
    
    @IBInspectable
    var extraBold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.extraBold.size(newValue)
        }
    }
    
    @IBInspectable
    var extraLight: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.extraLight.size(newValue)
        }
    }
    
    @IBInspectable
    var semiBold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.semiBold.size(newValue)
        }
    }
    
    @IBInspectable
    var medium: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.medium.size(newValue)
        }
    }
    
    @IBInspectable
    var regular: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.regular.size(newValue)
        }
    }
    
    @IBInspectable
    var light: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.light.size(newValue)
        }
    }
    
    @IBInspectable
    var black: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.black.size(newValue)
        }
    }
    
    @IBInspectable
    var bold: CGFloat {
        get {
            return fontSize
        } set {
            self.font = AppFontSystem.bold.size(newValue)
        }
    }
    
    fileprivate var fontSize: CGFloat {
        return font?.pointSize ?? 0
    }
}

extension UIButton {
    
    @IBInspectable
    var extraBold: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.extraBold.size(newValue)
        }
    }
    
    @IBInspectable
    var extraLight: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.extraLight.size(newValue)
        }
    }
    
    @IBInspectable
    var semiBold: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.semiBold.size(newValue)
        }
    }
    
    @IBInspectable
    var medium: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.medium.size(newValue)
        }
    }
    
    @IBInspectable
    var regular: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.regular.size(newValue)
        }
    }
    
    @IBInspectable
    var light: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.light.size(newValue)
        }
    }
    
    @IBInspectable
    var black: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.black.size(newValue)
        }
    }
    
    @IBInspectable
    var bold: CGFloat {
        get {
            return fontSize
        } set {
            self.titleLabel?.font = AppFontSystem.bold.size(newValue)
        }
    }
    
    fileprivate var fontSize: CGFloat {
        return titleLabel?.font.pointSize ?? 0
    }
}
