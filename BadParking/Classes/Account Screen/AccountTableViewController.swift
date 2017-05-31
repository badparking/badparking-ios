//
//  AccountTableViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/22/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AccountTableViewController: UITableViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)

         self.clearsSelectionOnViewWillAppear = true
    }

    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil) {
            // Process error
            print(error);
        } else if result.isCancelled {
            print("Login cancelled")
        } else {
            let fbToken = result.token.tokenString ?? ""
            print("token \(fbToken)")
            print(FBSDKAccessToken.current().tokenString)
            APIManager.shared.facebookAuth(fbToken) { error in
                if let err = error {
                    print(err);
                }
                if (APIManager.shared.user?.phone ?? "").isEmpty {
                    let alert = UIAlertController (
                        title: "Увага",
                        message: "Для того щоб ми могли з вами контактувати введіть будь ласка ваш номер телефону",
                        preferredStyle: UIAlertControllerStyle.alert
                    )
                    alert.addTextField(configurationHandler: { (textField: UITextField!) in
                        textField.placeholder = "+380xxxxxxxxx"
                    })
                    alert.addAction(UIAlertAction(title: "Добре", style: .default, handler: { (alertAction: UIAlertAction) in
                        var phone = alert.textFields?.first?.text ?? ""
                        phone = phone.replacingOccurrences(of: " ", with: "")
                        // Validate number locally
                        APIManager.shared.completetUser(phone: phone, email: nil, complete: { error in
                            if let err = error {
                                print(err)
                            }
                        })
                        return
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        AuthManager.shared.token = nil
        print("Did LogOut")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
