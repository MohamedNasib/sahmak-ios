import Foundation
import UIKit



enum AppColorSystem {
    case white
    case black
    case darkText
    case primary
    case secondary
    case LightGrey
    case Border
    
    var color : UIColor {
        switch self {
        case .white:
            return getColorByName(colorName: "white")
        case .black:
            return getColorByName(colorName: "black")
        case .darkText:
            return getColorByName(colorName: "Dark Text")
        case .primary:
            return getColorByName(colorName: "Primary")
        case .secondary:
            return getColorByName(colorName: "Secondary")
        case .LightGrey:
            return getColorByName(colorName: "LightGrey")
        case .Border:
            return getColorByName(colorName: "Border")
        }
    }
    
    var layerColor : CGColor {
        return self.color.cgColor
    }
    
    private func getColorByName(colorName : String) -> UIColor {
        
//        if #available(iOS 11.0, *) {
            return UIColor.init(named: colorName)!
//        } else {
            // Fallback on earlier versions
//            return UIColor.init(hexString: colorName)
//        }
    }
    
}
