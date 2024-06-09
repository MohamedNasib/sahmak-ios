//
//  Cattegories.swift
//  Sahmak
//
//  Created by mac on 08/07/2023.
//

import Foundation
import Mapper



struct FilterResponse: Mappable {
    var categories: [CattegoriesDetails] = []
    var maxPrice: Int = 0
    var minPrice: Int = 0

    init (map: Mapper) throws {
        categories = map.optionalFrom("categories") ?? []
        maxPrice = map.optionalFrom("maxPrice") ?? 0
        minPrice = map.optionalFrom("minPrice") ?? 0
    }
}

struct CattegoriesDetails: Mappable {
    var _id: String = ""
    var arabicName: String = ""
    var englishName: String = ""
    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
    }
}
