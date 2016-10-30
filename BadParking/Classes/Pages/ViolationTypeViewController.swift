//
//  ViolationTypeViewController.swift
//  BadParking
//
//  Created by Roman Simenok on 10/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViolationTypeViewController: BasePageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndexes: [IndexPath] = []
    var crimeTypes: [CrimeType]?
    @IBOutlet weak var nextPageButton: NextButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.index = 2
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        loadCrimeTypes()
    }

    func loadCrimeTypes() {
        SVProgressHUD.show()
        APIManager.shared.loadCrimeTypes { [unowned self] (crimeTypes, error) in
            if crimeTypes != nil {
                self.crimeTypes = crimeTypes
                self.tableView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crimeTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let crime = self.crimeTypes?[indexPath.row]
        
        cell.imageView?.image = UIImage.init(named: selectedIndexes.contains(indexPath) ? "violation_selected" : "violation_normal")
        cell.textLabel?.text = crime?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.remove(at: selectedIndexes.index(of: indexPath)!)
        } else {
            selectedIndexes.append(indexPath)
        }
        
        self.nextPageButton.isEnabled = selectedIndexes.count  > 0
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
