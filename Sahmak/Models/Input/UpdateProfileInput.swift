//
//  RegisterInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct UpdateProfileInput: Encodable {
    var name: String
    var gender: String
    var area: String
    var governorate: String
    var birthday: String
    var profilePicture: FileInput?
    var profileLanguage: String
    var isPrivate: Bool
}
