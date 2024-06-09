//
//  SignUpInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct ForgetPasswordInput: Encodable {
    var phoneNumber: String
    var password: String
    var confirmPassword: String
}
