//
//  ButtonNext.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 9/1/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation
import UIKit


class NextButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 31
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:1.0).cgColor
    }
}
