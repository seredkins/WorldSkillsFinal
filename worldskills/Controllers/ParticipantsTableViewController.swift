//
//  ParticipantsTableViewController.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class ParticipantsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchBarInput: String?
    
    var sectionsTitles = ["Конкурсанты", "Эксперты"]
    
    var searchBarResults = [Participant]()
    
    var participantArray = [[Participant]]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Type firstname or lastname"
        
        self.participantArray.append([Participant]())
        self.participantArray.append([Participant]())
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("participants").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [NSDictionary] else { return }
            
            for participant in value {
                guard let firstname = participant["firstname"] as? String,
                    let lastname = participant["lastname"] as? String,
                    let imageURLString = participant["photo"] as? String,
                    let imageURL = URL(string: imageURLString),
                    let role = participant["role"] as? String
                else { return }
                
                DispatchQueue.main.async {
                    if role == "конкурсант" {
                        self.participantArray[0].append(Participant(firstName: firstname, lastName: lastname, photoURL: imageURL, role: role, photo: nil))
                    } else {
                        self.participantArray[1].append(Participant(firstName: firstname, lastName: lastname, photoURL: imageURL, role: role, photo: nil))
                    }
                    
                }
                
                
                print("\(imageURL)/n")
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if participantArray.count <= section { return 0 }
        return participantArray[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ParticipantTableViewCell else { return UITableViewCell() }
        
        
        cell.indentationWidth = CGFloat(30.0)
        
        let session = URLSession(configuration: .default)
//        indexPath
        session.dataTask(with: participantArray[indexPath.section][indexPath.row].photoURL!) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
            }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.sync {
                cell.photoView?.image = image
                self.participantArray[indexPath.section][indexPath.row].photo = image
            }
        }.resume()
        
        cell.firstNameLabel.text = participantArray[indexPath.section][indexPath.row].firstName
        cell.lastNameLabel.text = participantArray[indexPath.section][indexPath.row].lastName
        cell.role = participantArray[indexPath.section][indexPath.row].role
        cell.imageurl = participantArray[indexPath.section][indexPath.row].photoURL
        
        return cell
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ["Конкурсанты", "Эксперты"]
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section]
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarInput = searchBar.text
        searchBar.text = ""
        
        for participantGroop in participantArray {
            for participant in participantGroop {
                if participant.firstName == searchBarInput || participant.lastName == searchBarInput {
                    searchBarResults.append(participant)
                }
            }
        }
        
        if searchBarResults.count > 0 {
            performSegue(withIdentifier: "toSearchResultsScreen", sender: searchBar)
        } else {
            searchBar.text = "Nothing found :( Try again!"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchResultsVC = segue.destination as? SearchResultsTableViewController,
            segue.identifier == "toSearchResultsScreen" else { return }
        
        
        searchResultsVC.searchResults = searchBarResults
        searchBarResults.removeAll()
    }
    
    
}
