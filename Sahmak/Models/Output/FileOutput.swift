//
//  LoginOutput.swift
//  Sahmak
//
//  Created by mac on 27/04/2023.
//

import Foundation
import Mapper

struct FileOutput: Mappable {
    
    var url = ""
    var publicId = ""
    var imageName = ""
    
    init (map: Mapper) throws {
        url = map.optionalFrom("url") ?? ""
        publicId = map.optionalFrom("publicId") ?? ""
        imageName = map.optionalFrom("imageName") ?? ""
    }
}
