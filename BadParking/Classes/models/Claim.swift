//
//  Claim.swift
//  BadParking
//
//  Created by Eugene Nagorny on 9/1/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Claim {
    // fixation screen
    var photos: [(name: String, image: UIImage)] = []
    var licensePlate: String?

    // location screen
    var city = "Київ"
    var address: String?
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?

    // crime tyeps screen
    var crimetypes: [CrimeType]?
}
