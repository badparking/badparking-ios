//
//  CrimeType.swift
//  BadParking
//
//  Created by Eugene Nagorny on 10/22/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit

class CrimeType: NSObject {
    let crimeTypeID : Int
    let name : String

    init(_ crimeTypeID: Int,_ name: String) {
        self.crimeTypeID = crimeTypeID
        self.name = name
    }

    override var description:String {
        return "CrimeType(id:\(crimeTypeID) name:\(name)"
    }
}
