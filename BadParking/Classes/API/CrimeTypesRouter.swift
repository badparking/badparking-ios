//
//  CrimeTypesRouter.swift
//  BadParking
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 BadParking. All rights reserved.
//
/*
import Foundation
import Alamofire


enum CrimeTypesRouter : URLRequestConvertible {
    case get(Int)
    case getAll

    var path: String {
        switch self {
        case .get(let pk):
            return "/types/\(pk)"
        case .getAll:
            return "/types"
        }
    }

    // MARK: URLRequestConvertible
    var urlRequest: URLRequest {
        let url = URL(string: Constants.API.URL)!
        return try! URLRequest(url: url.appendingPathComponent(path))
    }
    
}
*/
