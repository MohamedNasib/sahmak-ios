//
//  UIFont.swift
//  Bazzarry
//
//  Created by Mohamed Alhadadi  on 18/05/2022.
//

import Foundation
import UIKit

extension UIFont {

    class func regularFont(_ size: CGFloat) -> UIFont? {

        return UIFont(name: "Cairo-Regular", size: size )

    }
    
    class func mediumFont(_ size: CGFloat) -> UIFont? {

        return UIFont(name: "Cairo-SemiBold", size: size)

    }
    
    class func boldFont(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Cairo-Bold", size: size)
    }
}
