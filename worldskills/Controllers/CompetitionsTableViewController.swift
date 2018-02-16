//
//  DepartmentsTableViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class CompetitionsTableViewController: UITableViewController {
    
    var competitions = [Competition]()
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return competitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = competitions[indexPath.row].name
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailedCompVC = segue.destination as? DetailedCompetitionViewController,
            let cell = sender as? UITableViewCell,
            let cellIndexPath = tableView.indexPath(for: cell)?.row else { return }
        
        DetailedCompVC.name = competitions[cellIndexPath].name
        DetailedCompVC.block = competitions[cellIndexPath].block
        DetailedCompVC.desc = competitions[cellIndexPath].description
        DetailedCompVC.address = competitions[cellIndexPath].adress
        DetailedCompVC.image = competitions[cellIndexPath].image
        DetailedCompVC.location = competitions[cellIndexPath].location
    }

}
