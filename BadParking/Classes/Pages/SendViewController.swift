//
//  SendViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit

class SendViewController: BasePageViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
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
//            let fixationData = mainViewController?.getPhotosAndCarNumber()
            subtitles = [(mainViewController?.getViolationAddress())!, (mainViewController?.getViolations())!]
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
