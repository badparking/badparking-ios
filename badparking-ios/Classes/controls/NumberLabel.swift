//
//  NumberLabel.swift
//  badparking-ios
//
//  Created by Roman Simenok on 10/19/16.
//  Copyright © 2016 Badparking. All rights reserved.
//

import UIKit

class NumberLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15
    }

}
