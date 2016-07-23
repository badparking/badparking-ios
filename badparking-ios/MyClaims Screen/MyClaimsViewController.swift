//
//  MyClaimsViewController.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class MyClaimsViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton : FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did LogOut")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Login")
        if ((error) != nil)
        {
            // Process error
        } else if result.isCancelled {
            print("Login cancelled")
        } else {
            let token = result.token.tokenString
            print("token \(token)")
            print(FBSDKAccessToken.current().tokenString)
        }

    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("About to login")
        return true
    }


}

