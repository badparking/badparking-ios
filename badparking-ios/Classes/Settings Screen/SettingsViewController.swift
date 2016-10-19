//
//  SettingsViewController.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton : FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.delegate = self
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Login")
        if ((error) != nil)
        {
            // Process error
            print(error);
        } else if result.isCancelled {
            print("Login cancelled")
        } else {
            let token = result.token.tokenString
            print("token \(token)")
            print(FBSDKAccessToken.current().tokenString)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did LogOut")
    }

    @IBAction func closeWasPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
