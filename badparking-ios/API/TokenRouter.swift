//
//  TokenRouter.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 7/12/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import Alamofire


enum TokenRouter : URLRequestConvertible {
    case Verify(String)
    case Refresh(String)

    var path: String {
        switch self {
        case .Refresh(_):
            return "/token/refresh"
        case .Verify(_):
            return "/token/verify"
        }
    }

    // MARK: URLRequestConvertible
    var urlRequest: URLRequest {
        let url = URL(string: Constants.API.URL)!
        var mutableURLRequest = try! URLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = Alamofire.Method.POST.rawValue

        var token: String
        switch self {
        case .Verify(let tkn):
            token = tkn
        case .Refresh(let tkn):
            token = tkn
        }

        return Alamofire.ParameterEncoding.json.encode(mutableURLRequest, parameters: ["token": token]).0
        
    }
    
}
