//
//  LogoutOutput.swift
//  Sahmak
//
//  Created by Ahmed El-elaimy on 05/07/2023.
//

import Foundation
import Mapper

struct LogoutOutput: Mappable {
    let code: Int
    let message: String

    init(map: Mapper) throws {
        try code = map.from("code")
        try message = map.from("message")
    }
}
