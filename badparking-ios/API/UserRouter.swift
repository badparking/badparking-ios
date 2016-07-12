//
//  UserRouter.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter : URLRequestConvertible {
    case Me

    var path: String {
        switch self {
        case .Me:
            return "/user/me"
        }
    }

    // MARK: URLRequestConvertible
    var urlRequest: URLRequest {
        let url = URL(string: Constants.API.URL)!
        return try! URLRequest(url: url.appendingPathComponent(path))
    }

}
