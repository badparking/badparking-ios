//
//  CrimeType.swift
//  BadParking
//
//  Created by Eugene Nagorny on 10/22/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import ObjectMapper

class CrimeType: Mappable, Equatable, CustomStringConvertible {
    var crimeTypeID: Int?
    var name: String?

    required init?(map: Map){

    }

    func mapping(map: Map) {
        crimeTypeID <- map["id"]
        name        <- map["name"]
    }

    var description: String {
        return "CrimeType(id:\(crimeTypeID) name:\(name)"
    }

    static func == (lhs: CrimeType, rhs: CrimeType) -> Bool{
        return lhs.crimeTypeID == rhs.crimeTypeID && lhs.name == rhs.name
    }
}
