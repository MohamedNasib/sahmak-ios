//
//  StringLocationExtension.swift
//
//  Created by Hassan on 6/21/21.
//

import Foundation



extension String {

    
    func deleteLeadingZeros() -> String {
      var resultStr = self
        
      while resultStr.hasPrefix("0") && resultStr.count > 1 {
       resultStr.removeFirst()
      }
      return resultStr
    }
}
