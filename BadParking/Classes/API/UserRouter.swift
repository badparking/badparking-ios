//
//  UserRouter.swift
//  BadParking
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import Foundation
import Alamofire


enum UserRouter : URLRequestConvertible {
    case me(headers: Dictionary<String, String>)
    case complete(phone: String?, email: String?, headers: Dictionary<String, String>)
    case authFB(fbToken: String, security: Dictionary<String, String>)

    var path: String {
        switch self {
        case .me:
            return "/user/me"
        case .authFB:
            return "/user/auth/facebook"
        case .complete:
            return "/user/auth/complete"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .me:
            return .get
        case .authFB:
            return .post
        case .complete:
            return .put
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseURL = try! Constants.API.URL.asURL()

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .authFB(let fbToken, let security):
            urlRequest = try! URLEncoding.queryString.encode(urlRequest, with: security)
            urlRequest = try! URLEncoding.httpBody.encode(urlRequest, with: ["access_token": fbToken])
        case .me(let headers):
            for (header, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: header)
            }
        case .complete(let phone, let email, let headers):
            for (header, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: header)
            }
            var params = Dictionary<String, String>()
            if let phone = phone {
                params["phone"] = phone
            }
            if let email = email {
                params["email"] = email
            }
            if params.count > 0 {
                urlRequest = try! URLEncoding.httpBody.encode(urlRequest, with: params)
            }
        }

        return urlRequest
    }
}
