//
//  UITextField+Extensions.swift
//
//  Created by hassan on 11/10/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var wrapedText : String {
        return self.text ?? ""
    }

}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
