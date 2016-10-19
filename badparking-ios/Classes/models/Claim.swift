//
//  Claim.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 9/1/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Claim {
    var photos: [(name: String, image: UIImage)] = []

    var city: String?
    var address: String?

    var crimetypes: [Int]?
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
}
