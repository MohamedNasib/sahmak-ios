//
//  File.swift
//  Sahmak
//
//  Created by mac on 14/05/2023.
//

import Foundation
import Mapper

struct Card: Mappable {
   
    var message = ""
    var data : CardDetails?
    var totalCount = 0
    var code = 0
    
    
    init (map: Mapper) throws {
        
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data")
        totalCount = map.optionalFrom("totalCount") ?? 0
        code = map.optionalFrom("code") ?? 0
        
    }
}

struct CardDetails: Mappable {
    var _id = ""
    var creditCards : [CreditCards] = []

    
    init (map: Mapper) throws  {
        
        _id = map.optionalFrom("_id") ?? ""
        creditCards = map.optionalFrom("creditCards") ?? []
    }
}

struct CreditCards: Mappable {
    var payMobOrderId = 0
    var isDefault = false
    var isVerified = false
    var paymentToken = ""
    var _id = ""
    var cardToken = ""
    var cardType = ""
    var creditCardNumber = 0

    
    init (map: Mapper) throws  {
        
        payMobOrderId = map.optionalFrom("payMobOrderId") ?? 0
        isDefault = map.optionalFrom("isDefault") ?? false
        isVerified = map.optionalFrom("isVerified") ?? false
        paymentToken = map.optionalFrom("paymentToken") ?? ""
        _id = map.optionalFrom("_id") ?? ""
        cardToken = map.optionalFrom("cardToken") ?? ""
        cardType = map.optionalFrom("cardType") ?? ""
        creditCardNumber = map.optionalFrom("creditCardNumber") ?? 0
    }
}


