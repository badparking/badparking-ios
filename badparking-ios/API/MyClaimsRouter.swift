//
//  Router.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 7/11/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import Alamofire


enum MyClaimsRouter: URLRequestConvertible {
    case Create([String: AnyObject])
    case Get(String)
    case GetAll
    case Update(String, [String: AnyObject])

    static var JWToken: String?

    var method: Alamofire.Method {
        switch self {
        case .Create:
            return .POST
        case .Get,
             .GetAll:
            return .GET
        case .Update:
            return .PATCH
        }
    }

    var path: String {
        switch self {
        case .Create,
             .GetAll:
            return "/claims/my"
        case .Get(let pk):
            return "/claim/my/\(pk)"
        case .Update(let pk, _):
            return "/claims/my/\(pk)"
        }
    }

    // MARK: URLRequestConvertible
    var urlRequest: URLRequest {
        let url = URL(string: Constants.API.URL)!
        var mutableURLRequest = try! URLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue

        MyClaimsRouter.JWToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjExMTI2MTgyMjIiLCJ1c2VyX2lkIjozLCJmdWxsX25hbWUiOiJBaXZhcmFzIEFicm9tYXZpXHUwMTBkaXVzIiwiZW1haWwiOiJhaXZhcmFzQGFicm9tYXZpY2hpdXMuY29tIiwiZXhwIjoxNDY4MjQzOTQ2LCJpc19jb21wbGV0ZSI6dHJ1ZSwib3JpZ19pYXQiOjE0NjgyNDIxNDZ9.atFjhyvgNKXMzGFRGrdVQ1TPRlk-8eoHfBRanLKGW4c"

        // TODO: check JWToken for expire and request refresh token before processing further
        if let token = MyClaimsRouter.JWToken {
            mutableURLRequest.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }


        return mutableURLRequest
    }
}

