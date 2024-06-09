//
//  SignUpInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct AddCardInput: Encodable {
    var creditCardNumber: Int
    var cardId: String
    var payMobOrderId: Int
    var cardType: String
    var cardToken: String
}
