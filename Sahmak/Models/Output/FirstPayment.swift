//
//  FirstPayment.swift
//  Sahmak
//
//  Created by Ahmed El-elaimy on 10/07/2023.
//

import Foundation
import Mapper

struct FirstPayment: Mappable {
    
    var code: Int
    var message: String
    var data: PaymentData?
    
    init(map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data")
    }
}

struct PaymentData: Mappable {
    
    var payMobOrderId: Int
    var cardId: String
    var paymentToken: String
    
    init(map: Mapper) throws {
        payMobOrderId = map.optionalFrom("payMobOrderId") ?? 0
        cardId = map.optionalFrom("cardId") ?? ""
        paymentToken = map.optionalFrom("paymentToken") ?? ""
    }
}

