//
//  SignUpInput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation

struct SignUpInput: Encodable {
    var phoneNumber: String
    var password: String
    var confirmPassword: String
}


struct SendProposalInput: Encodable {
    var deposit: Int
    var totalInvestmentMoney: Int
}

struct PrpertyFilterInput: Encodable {
    var categoryId: String
    var date: String
    var minPrice: Int
    var maxPrice: Int
    var searchText: String
    var page: Int
}

struct SavedPrpertyInput: Encodable {
    var page: Int
}
