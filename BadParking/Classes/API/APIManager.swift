//
//  APIManager.swift
//  BadParking
//
//  Created by Eugene Nagorny on 10/22/16.
//  Copyright © 2016 BadParking. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON


class APIManager: NSObject {
    static let shared = APIManager()
    var user: User?

    var jwtHeaders: Dictionary<String, String>? {
        guard let jwtToken = AuthManager.shared.token else {
            return nil;
        }
        return ["Authorization": "JWT \(jwtToken)"]
    }

    private override init() {
        return;
    }

    func loadCrimeTypes(complete: @escaping ([CrimeType]?, Error?) -> Void) -> Void {
        Alamofire
            .request(CrimeTypesRouter.getAll)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let crimeTypes = JSON(value).arrayValue.map( {CrimeType($0["id"].intValue, $0["name"].stringValue)} )
                    complete(crimeTypes, nil)
                case .failure(let error):
                    complete(nil, error)
                }
        }
    }

    func facebookAuth(_ fbToken : String, complete: @escaping (Error?) -> Void) -> Void {
        Alamofire
            .request(UserRouter.authFB(fbToken: fbToken, security: AuthManager.shared.generateSecret()))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    let json = JSON(value)
                    AuthManager.shared.token = json["token"].string ?? ""
                    complete(nil)
                case .failure(let error):
                    print(error)
                    complete(error)
                }
        }
    }

    func userMe(complete: @escaping (User?, Error?) -> Void) -> Void {
        guard let jwtHeaders = jwtHeaders else {
            return
        }
        Alamofire
            .request(UserRouter.me(headers: jwtHeaders))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    // TODO: parse user here
                    let user = User()
                    complete(user, nil)
                case .failure(let error):
                    complete(nil, error)
                }
        }

    }
}
