//
//  SendViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SendViewController: BasePageViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var facebookVIew: UIView!
    var claim:Claim?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.claim = (self.parent?.parent as! MainViewController).claim
        self.index = 3
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check if user logged in with FB and has phone number associated
        guard FBSDKAccessToken.current() == nil else {
            facebookVIew.isHidden = true
            return
        }
        facebookVIew.isHidden = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountTableViewController") as! AccountTableViewController
        //        self.present(accountVC, animated: true, completion: nil)

        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = accountVC
        facebookVIew.addSubview(loginButton)
        loginButton.center = CGPoint(x: facebookVIew.bounds.width/2, y: facebookVIew.bounds.height/2)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning can be 4 if we have additional info
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? "photosCell" : "cell", for: indexPath)

        if indexPath.row == 0 {  // photos
            let icon = cell.viewWithTag(1) as! UIImageView
            icon.image = #imageLiteral(resourceName: "photosIcon")

            let stackView = cell.viewWithTag(2) as! UIStackView
            let firstImage = stackView.viewWithTag(3) as! UIImageView
            let secondImage = stackView.viewWithTag(4) as! UIImageView

            firstImage.image = claim?.photos[0].image
            secondImage.image = claim?.photos[1].image
        } else if indexPath.row == 1 {  // location
            (cell.viewWithTag(1) as! UIImageView).image = #imageLiteral(resourceName: "locationIcon")
            (cell.viewWithTag(2) as! UILabel).text = "Адреса:"
            (cell.viewWithTag(3) as! UILabel).text = claim?.address ?? ""
        } else if indexPath.row == 2 {  // crime types
            (cell.viewWithTag(1) as! UIImageView).image = #imageLiteral(resourceName: "violation")
            (cell.viewWithTag(2) as! UILabel).text = "Порушення:"
            (cell.viewWithTag(3) as! UILabel).text = claim?.crimetypes.map({$0.name ?? ""}).joined(separator: "\n")
        }
        return cell
    }
    
    // MARK: IBActions
    @IBAction func sendViolationPressed(_ sender: NextButton) {
        // #warnind send data to server
    }
    
}
