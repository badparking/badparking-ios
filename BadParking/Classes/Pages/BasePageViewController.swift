//
//  BasePageViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit

protocol PageDelegate {
    func showViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection)
}

class BasePageViewController: UIViewController {

    var index: Int = 0
    var delegate: PageDelegate?
    
    @IBAction func nextPagePressed(_ sender: NextButton) {
        self.delegate?.showViewControllerAtIndex(index: self.index+1, direction: .forward)
    }
    
    @IBAction func previousPagePressed(_ sender: NextButton) {
        self.delegate?.showViewControllerAtIndex(index: self.index-1, direction: .reverse)
    }
    
}
