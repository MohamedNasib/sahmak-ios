//
//  LoginOutput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation
import Mapper

struct GetContactUsResponse: Mappable {
    var _id = ""
    var email = ""
    var address = ""
    var createdAt = ""
    var updatedAt = ""
    var __v = 0
   
    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        email = map.optionalFrom("email") ?? ""
        address = map.optionalFrom("address") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        __v = map.optionalFrom("_id") ?? 0
    }
}


struct GetTermsResponse: Mappable {
    var _id = ""
    var arabicText = ""
    var englishText = ""
    var createdAt = ""
    var updatedAt = ""
    var __v = 0
   
    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        arabicText = map.optionalFrom("arabicText") ?? ""
        englishText = map.optionalFrom("englishText") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        __v = map.optionalFrom("_id") ?? 0
    }
}



struct GetListFAQSResponse: Mappable {
    var code = 0
    var message = ""
    var data : [FAQDataDetails] = []
   
    init (map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data") ?? []
        
    }
}

struct FAQDataDetails: Mappable {
    var _id  = ""
    var arabicQuestion  = ""
    var englishQuestion  = ""
    var englishAnswer  = ""
    var arabicAnswer  = ""
    
    var isCollapsed = true
   
    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        arabicQuestion = map.optionalFrom("arabicQuestion") ?? ""
        englishQuestion = map.optionalFrom("englishQuestion") ?? ""
        englishAnswer = map.optionalFrom("englishAnswer") ?? ""
        arabicAnswer = map.optionalFrom("arabicAnswer") ?? ""
    }
}





