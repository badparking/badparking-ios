//
//  MainViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PageDelegate {

    @IBOutlet weak var pageIndicationView: UIView!
    @IBOutlet weak var pagesNumbersStackView: UIStackView!
    var pageViewController: UIPageViewController!
    var claim = Claim()
    
    lazy var fixationViewController: FixationViewController! = {
        let fixationVC = self.storyboard?.instantiateViewController(withIdentifier: "fixation") as! FixationViewController
        fixationVC.delegate = self
        return fixationVC
    }()
    lazy var locationViewController: LocationViewController! = {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "location") as! LocationViewController
        locationVC.delegate = self
        return locationVC
    }()
    lazy var violationTypeViewController: ViolationTypeViewController! = {
        let violationTypeVC = self.storyboard?.instantiateViewController(withIdentifier: "violation") as! ViolationTypeViewController
        violationTypeVC.delegate = self
        return violationTypeVC
    }()
    lazy var sendViewController: SendViewController! = {
        let sendVC = self.storyboard?.instantiateViewController(withIdentifier: "send") as! SendViewController
        sendVC.delegate = self
        return sendVC
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create pageViewController
        pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // add it's view as childView
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        // disable autoresizing
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // add constrains
        let pinTop = NSLayoutConstraint(item: pageIndicationView, attribute: .bottom, relatedBy: .equal,
                                        toItem: pageViewController.view, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal,
                                           toItem: pageViewController.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal,
                                         toItem: pageViewController.view, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal,
                                          toItem: pageViewController.view, attribute: .right, multiplier: 1.0, constant: 0)
        
        self.view.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
        
        // set default viewController
        pageViewController.setViewControllers([fixationViewController], direction:.forward, animated: false, completion: nil)
    }
    
    func getViewControllerForIndex(index: Int) -> UIViewController? {
        if index == 0 {
            return fixationViewController
        } else if index == 1 {
            return locationViewController
        } else if index == 2 {
            return violationTypeViewController
        } else if index == 3 {
            return sendViewController
        } else {
            return nil
        }
    }
    
    // MARK: - PageDelegate
    func showViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
        let newPage = getViewControllerForIndex(index: index)!
        pageViewController.setViewControllers([newPage], direction: direction, animated: true, completion: nil)
        
        let number = pagesNumbersStackView.subviews[index] as! UILabel
        number.backgroundColor = UIColor(red:0.39, green:0.78, blue:0.00, alpha:1.0)
        number.textColor = UIColor.white
        let prevNumber = pagesNumbersStackView.subviews[index + (direction == .forward ? -1 : 1)] as! UILabel
        prevNumber.backgroundColor = UIColor.white
        prevNumber.textColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
    }
 
    // MARK: - Send Data
    func getViolations() -> String {
        let selectedViolationIndexes = violationTypeViewController.selectedIndexes
        let crimes = violationTypeViewController.crimeTypes
        
        var violations = ""
        for indexPath in selectedViolationIndexes {
            let crime = crimes![indexPath.row]
            
            if violations.isEmpty {
                violations = "- \(crime.name!)"
            } else {
                violations = "\(violations)\n- \(crime.name!)"
            }
        }
        
        return violations
    }
}
