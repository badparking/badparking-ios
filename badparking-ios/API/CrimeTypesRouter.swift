//
//  CrimeTypesRouter.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import Alamofire


enum CrimeTypesRouter : URLRequestConvertible {
    case Get(Int)
    case GetAll

    var path: String {
        switch self {
        case .Get(let pk):
            return "/types/\(pk)"
        case .GetAll:
            return "/types"
        }
    }

    // MARK: URLRequestConvertible
    var urlRequest: URLRequest {
        let url = URL(string: Constants.API.URL)!
        return try! URLRequest(url: url.appendingPathComponent(path))
    }
    
}
