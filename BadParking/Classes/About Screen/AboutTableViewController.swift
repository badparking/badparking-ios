//
//  AboutViewController.swift
//  BadParking
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version \(version)"
            if let build = Bundle.main.infoDictionary?[(kCFBundleVersionKey as String)] as? String {
                versionLabel.text = versionLabel.text! + " Build \(build)"
            }
        }
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }

    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    // MARK: TableView Delegate And DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = "Ліцензії"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "licenses", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
