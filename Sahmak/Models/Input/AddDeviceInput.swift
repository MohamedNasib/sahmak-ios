//
//  SignUpInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct AddDeviceInput: Encodable {
    var token: String
    var deviceId: String
    var type: String
}
