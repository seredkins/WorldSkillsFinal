//
//  SearchResultsTableViewController.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    var searchResults = [Participant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ParticipantTableViewCell else { return UITableViewCell() }
        cell.indentationWidth = CGFloat(30.0)
        
        cell.firstNameLabel.text = searchResults[indexPath.row].firstName
        cell.lastNameLabel.text = searchResults[indexPath.row].lastName
        cell.role = searchResults[indexPath.row].role
        cell.photoView?.image = searchResults[indexPath.row].photo
        
        return cell
    }
}
