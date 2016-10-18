//
//  MainViewController.swift
//  badparking-ios
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PageDelegate {

    var pageViewController: PageViewController!
    
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
    }
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pagevc" {
            pageViewController = segue.destination as! PageViewController
            pageViewController.setViewControllers([fixationViewController], direction:.forward, animated: false, completion: nil)
        }
    }
}
