//
//  ViolationTypeViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViolationTypeViewController: BasePageViewController {

    var crimeTypes: [CrimeType]? {
        didSet {
            print("hide loading indicator and update UI with \(crimeTypes)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.index = 2
        loadCrimeTypes()
    }

    func loadCrimeTypes() {
        Alamofire.request(CrimeTypesRouter.getAll).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                self.crimeTypes = JSON(value).arrayValue.map( {CrimeType($0["id"].intValue, $0["name"].stringValue)} )
            case .failure(let error):
                print(error)
            }
        }
    }
}
