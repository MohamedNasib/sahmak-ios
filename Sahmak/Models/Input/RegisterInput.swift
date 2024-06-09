//
//  RegisterInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct RegisterInput: Encodable {
    var name: String
    var phoneNumber: String
    var gender: String
    var area: String
    var governorate: String
    var birthday: String
    var egyptianIdNumber: String
    var profilePicture: FileInput
    var egyptianIdPhotoFront: FileInput
    var egyptianIdPhotoBack: FileInput
}
