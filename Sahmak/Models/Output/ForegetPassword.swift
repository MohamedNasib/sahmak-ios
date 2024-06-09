//
//  ForegetPassword.swift
//  Sahmak
//
//  Created by mac on 10/07/2023.
//

import Foundation
import Mapper

struct ForegetPasswordResponse: Mappable {
    
    var code = 0
    var message = ""
    var data: IsVerifiedDetaills?
    
    init (map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data")
    }
}

struct IsVerifiedDetaills: Mappable {
        var isVerified = false
    init (map: Mapper) throws {
        isVerified = map.optionalFrom("isVerified") ?? false
    }
}
