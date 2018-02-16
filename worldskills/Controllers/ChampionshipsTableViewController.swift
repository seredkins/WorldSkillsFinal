//
//  CompetitionsTableViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ChampionshipsTableViewController: UITableViewController {
    
    var championshipsArray = [Championship]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        championshipsArray = ["Digitall Skills", "World Skills"]
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("championships").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? [NSDictionary] else { return }
            
            for championship in value {
                
                guard let dateStart = championship["date-start"] as? Double,
                    let dateEnd = championship["date-end"] as? Double,
                    let name = championship["name"] as? String,
                    let competitionsDict = championship["competitions"] as? [NSDictionary]
                else { return }
                
                var competitions = [Competition]()
                
                for competition in competitionsDict {
                    guard let address = competition["address"] as? String,
                        let block = competition["block"] as? String,
                        let description = competition["description"] as? String,
                        let imageUrl = competition["image"] as? String,
                        let smpUrl = competition["smp"] as? String,
                        let location = competition["location"] as? [Any],
                        let name = competition["name"] as? String else { return }
                    
                    print("Image: \(imageUrl)")
                    print("SMP: \(smpUrl)")

                    competitions.append(Competition(adress: address, block: block, description: description, image: nil, name: name, location: [location[0] as! Double, location[1] as! Double]))
                }
                
                DispatchQueue.main.async {
                    self.championshipsArray.append(Championship(dateStart: dateStart, dateEnd: dateEnd, name: name, competitions: competitions))
                }
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
        return championshipsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = championshipsArray[indexPath.row].name
        return cell
    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let CompetitionsTableVC = segue.destination as? CompetitionsTableViewController,
            let cell = sender as? UITableViewCell,
            let cellIndexPath = tableView.indexPath(for: cell) else { return }
        
        if championshipsArray[cellIndexPath.row].competitions!.count > 1 {
            championshipsArray[cellIndexPath.row].competitions![0].image = #imageLiteral(resourceName: "competition1")
            championshipsArray[cellIndexPath.row].competitions![1].image = #imageLiteral(resourceName: "competition_12")
            championshipsArray[cellIndexPath.row].competitions![2].image = #imageLiteral(resourceName: "competition_17")
            championshipsArray[cellIndexPath.row].competitions![3].image = #imageLiteral(resourceName: "competition_04")
        } else {
            championshipsArray[cellIndexPath.row].competitions![0].image = #imageLiteral(resourceName: "competition_23")
        }
        
        
        CompetitionsTableVC.competitions = championshipsArray[cellIndexPath.row].competitions!
    }
}
