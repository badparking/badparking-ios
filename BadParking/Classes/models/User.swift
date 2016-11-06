//
//  User.swift
//  BadParking
//
//  Created by Eugene Nagorny on 10/30/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var first_name: String?
    var middle_name: String?
    var last_name: String?
    var full_name: String?
    var email: String?
    var inn: String?
    var phone: String?
    var is_complete: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        first_name  <- map["first_name"]
        middle_name <- map["middle_name"]
        last_name   <- map["last_name"]
        full_name   <- map["full_name"]
        email       <- map["email"]
        inn         <- map["inn"]
        phone       <- map["phone"]
        is_complete <- map["is_complete"]
    }
}
