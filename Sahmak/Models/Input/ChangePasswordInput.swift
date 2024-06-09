//
//  SignUpInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation
import Mapper

struct ChangePasswordInput: Encodable {
    var oldPassword :String
    var newPassword :String
    var confirmPassword :String
    
}


struct ChangePasswordResponse: Mappable {
    var message  = ""
    var token  = ""
    var code  = 0

    
    init (map: Mapper) throws  {
        message = map.optionalFrom("message") ?? ""
        token = map.optionalFrom("token") ?? ""
        code = map.optionalFrom("code") ?? 0
    }
}



