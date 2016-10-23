//
//  TokenRouter.swift
//  BadParking
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import Foundation
import Alamofire


enum TokenRouter : URLRequestConvertible {
    case verify(String)
    case refresh(String)

    var path: String {
        switch self {
        case .refresh(_):
            return "/token/refresh"
        case .verify(_):
            return "/token/verify"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.URL.asURL()
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = HTTPMethod.post.rawValue

        var token: String
        switch self {
        case .verify(let tkn):
            token = tkn
        case .refresh(let tkn):
            token = tkn
        }

        return try URLEncoding.default.encode(mutableURLRequest, with: ["token": token])
    }

}

