//
//  Double+Extensions.swift
//  Bazzarry
//
//  Created by Mohammed Mirsal on 21/09/2022.
//

import Foundation


extension Double {
    var formattedPrice: String {
        return String(format: "%.2f", self)
    }
}
