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
import AlamofireObjectMapper
import ObjectMapper


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
            .responseArray { (response:DataResponse<[CrimeType]>) in
                complete(response.result.value, response.result.error)
        }
    }

    func facebookAuth(_ fbToken : String, complete: @escaping (Error?) -> Void) -> Void {
        Alamofire
            .request(UserRouter.authFB(fbToken: fbToken, security: AuthManager.shared.generateSecret()))
            .validate()
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    self.user = User(JSONString: json.rawString()!)
                    AuthManager.shared.token = json["token"].string
                }
                complete(response.result.error)
        }
    }

    func completetUser(phone: String?, email: String?, complete: @escaping (Error?) -> Void) -> Void {
        Alamofire
            .request(UserRouter.complete(phone: phone, email: email, token: AuthManager.shared.token!))
            .validate()
            .responseJSON { response in
                if let value = response.result.value {
                    // TODO: improve converting json to object
                    let json = JSON(value)
                    self.user = User(JSONString: json.rawString()!)
                }
                complete(response.result.error)
        }
    }

    func userMe(complete: @escaping (User?, Error?) -> Void) -> Void {
        guard let jwtHeaders = jwtHeaders else {
            return
        }
        Alamofire
            .request(UserRouter.me(headers: jwtHeaders))
            .validate()
            .responseObject { (response:DataResponse<User>) in
                self.user = response.result.value
                complete(response.result.value, response.result.error)
        }
    }
}
