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
    let titles = ["Адреса:", "Порушення:"]
    var subtitles: [String] = []
    let images = [#imageLiteral(resourceName: "locationIcon"), #imageLiteral(resourceName: "violation")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.index = 3
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutSubviews()
        // check if user logged in with FB and has phone number associated
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountTableViewController") as! AccountTableViewController
        //        self.present(accountVC, animated: true, completion: nil)

        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = accountVC
        facebookVIew.addSubview(loginButton)
        loginButton.center = CGPoint(x: facebookVIew.bounds.width/2, y: facebookVIew.bounds.height/2)
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

        if indexPath.row == 0 {
            let icon = cell.viewWithTag(1) as! UIImageView
            icon.image = #imageLiteral(resourceName: "photosIcon")
            
            let stackView = cell.viewWithTag(2) as! UIStackView
            let firstImage = stackView.viewWithTag(3) as! UIImageView
            let secondImage = stackView.viewWithTag(4) as! UIImageView
            
            let mainViewController = self.parent?.parent as? MainViewController
            let claim = mainViewController?.claim
            subtitles.append(claim?.address ?? "")
            let crimeNames = claim?.crimetypes.flatMap {$0.name}
            subtitles.append(crimeNames?.joined(separator: " - ") ?? "")
            firstImage.image = claim?.photos[0].image
            secondImage.image = claim?.photos[1].image
        } else {
            let icon = cell.viewWithTag(1) as! UIImageView
            icon.image = images[indexPath.row-1]
            
            let title = cell.viewWithTag(2) as! UILabel
            title.text = titles[indexPath.row-1]
            let subTitle = cell.viewWithTag(3) as! UILabel
            subTitle.text = subtitles[indexPath.row-1]
        }

        return cell
    }
    
    // MARK: IBActions
    @IBAction func sendViolationPressed(_ sender: NextButton) {
        // #warnind send data to server
    }
    
}
