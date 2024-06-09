//
//  LoginOutput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation
import Mapper

struct User: Mappable {
    var egyptianIdPhotoFront: FileOutput?
    var egyptianIdPhotoBack: FileOutput?
    var profilePicture: FileOutput?
    var _id = ""
    var password = ""
    var phoneNumber = ""
    var profileLanguage = ""
    var isPrivate = false
    var isDeactivated = false
    var isVerified = false
    var getNotifications = false
    var creditCards: [CardDetails] = []
    var devices: [String] = []
    var createdAt = ""
    var updatedAt = ""
    var __v = 0
    var birthday = ""
    var city: CitiesOutput?
    var egyptianIdNumber = ""
    var gender = ""
    var governorate: GovernorateOutput?
    var name = ""
    var token = ""
    
    var userId = ""
    
    init (map: Mapper) throws {
        egyptianIdPhotoFront = map.optionalFrom("egyptianIdPhotoFront")
        egyptianIdPhotoBack = map.optionalFrom("egyptianIdPhotoBack")
        profilePicture = map.optionalFrom("profilePicture")
        _id = map.optionalFrom("_id") ?? ""
        password = map.optionalFrom("password") ?? ""
        phoneNumber = map.optionalFrom("phoneNumber") ?? ""
        profileLanguage = map.optionalFrom("profileLanguage") ?? ""
        isPrivate = map.optionalFrom("isPrivate") ?? false
        isDeactivated = map.optionalFrom("isDeactivated") ?? false
        isVerified = map.optionalFrom("isVerified") ?? false
        getNotifications = map.optionalFrom("getNotifications") ?? false
        creditCards = map.optionalFrom("creditCards") ?? []
        devices = map.optionalFrom("devices") ?? []
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        __v = map.optionalFrom("__v") ?? 0
        birthday = map.optionalFrom("birthday") ?? ""
        city = map.optionalFrom("area")
        egyptianIdNumber = map.optionalFrom("egyptianIdNumber") ?? ""
        gender = map.optionalFrom("gender") ?? ""
        governorate = map.optionalFrom("governorate")
        name = map.optionalFrom("name") ?? ""
        token = map.optionalFrom("token") ?? ""
        
        userId = map.optionalFrom("userId") ?? ""
    }
}

struct GovernorateOutput: Mappable {
    var _id = ""
    var arabicName = ""
    var englishName = ""

    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
    }
}

struct CitiesOutput: Mappable {
    var _id = ""
    var arabicName = ""
    var englishName = ""

    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
    }
}


