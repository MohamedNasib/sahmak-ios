//
//  AttributedString+Extension.swift
//  Bazzarry
//
//  Created by Mohammed Mirsal on 24/08/2022.
//

import Foundation


extension NSAttributedString {
    static func strikethroughAttributed(string: String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: string)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
}
