//
//  ButtonNext.swift
//  BadParking
//
//  Created by Eugene Nagorny on 9/1/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import Foundation
import UIKit

class NextButton: UIButton {
    
    let mainLayer: CAShapeLayer! = CAShapeLayer.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // add border
        self.layer.cornerRadius = 22;
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(self.isEnabled ? 1.0 : 0.4).cgColor
        
        // add green round rect
        let bezierPath = UIBezierPath.init(roundedRect: CGRect.init(x: 4, y: 4, width: 92, height: 36), cornerRadius: 18)
        mainLayer.path = bezierPath.cgPath
        mainLayer.fillColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:self.isEnabled ? 1.0 : 0.4).cgColor
        self.layer .addSublayer(mainLayer)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.7).cgColor
                mainLayer.fillColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:0.7).cgColor
            } else {
                self.layer.borderColor = UIColor.darkGray.cgColor
                mainLayer.fillColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:1.0).cgColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.layer.borderColor = UIColor.darkGray.cgColor
                mainLayer.fillColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:1.0).cgColor
            } else {
                self.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.4).cgColor
                mainLayer.fillColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:0.4).cgColor
            }
        }
    }
    
}
