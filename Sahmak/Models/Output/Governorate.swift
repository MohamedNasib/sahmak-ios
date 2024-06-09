//
//  Governorate.swift
//  Sahmak
//
//  Created by Ahmed El-elaimy on 29/05/2023.
//

import Foundation
import Mapper

struct Area: Mappable {
    var id: String = ""
    var arabicName: String = ""
    var englishName: String = ""
    var governorate: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var v: Int = 0

    init (map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
        governorate = map.optionalFrom("governorate") ?? ""
        
        let dateFormatter = ISO8601DateFormatter()
        createdAt = map.optionalFrom("createdAt", transformation: { dateFormatter.date(from: $0 as! String) }) ?? Date()
        updatedAt = map.optionalFrom("updatedAt", transformation: { dateFormatter.date(from: $0 as! String) }) ?? Date()
        
        v = map.optionalFrom("__v") ?? 0
    }
}

struct Governorate: Mappable {
    var id: String = ""
    var arabicName: String = ""
    var englishName: String = ""
    var areas: [Area] = []

    init (map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
        areas = map.optionalFrom("areas") ?? []
    }
}

struct GovernorateResponse: Mappable {
    var code: Int = 0
    var message: String = ""
    var data: [Governorate] = []

    init (map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data") ?? []
    }
}
