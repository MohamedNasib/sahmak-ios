//
//  ContactUsInput.swift
//  Sahmak
//
//  Created by mac on 15/05/2023.
//

import Foundation


struct ContactUsInput: Encodable {
    var email : String
    var phoneNumber : String
    var message : String
    var name : String
}
