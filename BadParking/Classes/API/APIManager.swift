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

    private override init() {
        return;
    }

    func loadCrimeTypes(result: @escaping ([CrimeType]?, Error?) -> Void) -> Void {
        Alamofire.request(CrimeTypesRouter.getAll).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let crimeTypes = JSON(value).arrayValue.map( {CrimeType($0["id"].intValue, $0["name"].stringValue)} )
                result(crimeTypes, nil)
            case .failure(let error):
                result(nil, error)
            }
        }
    }
}
