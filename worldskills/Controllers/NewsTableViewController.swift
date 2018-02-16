//
//  NewsTableViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class NewsTableViewController: UITableViewController {
    
    @IBAction func toProfile(_ sender: UIButton) {
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toProfileScreen", sender: self)
        } else {
            performSegue(withIdentifier: "toSignInScreen", sender: self)
        }
        
    }
    
    var newsArray = [News]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("news").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? [NSDictionary] else { return }
            
            var i = 0
            for news in value {
                guard let date = news["date"] as? Double,
                    let description = news["description"] as? String,
                    let imageURL = news["image"] as? String,
                    let name = news["name"] as? String
                else { return }
                
                print("\(imageURL)/n")
                
                DispatchQueue.main.async {
                    if i % 2 == 0 {
                        self.newsArray.append(News(newsDate: Date.init(timeIntervalSince1970: date), newsBody: description, newsImage: #imageLiteral(resourceName: "image1"), newsTitle: name))
                    } else {
                        self.newsArray.append(News(newsDate: Date.init(timeIntervalSince1970: date), newsBody: description, newsImage: #imageLiteral(resourceName: "image2"), newsTitle: name))
                    }
                    i += 1
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
        return self.newsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = newsArray[indexPath.row].newsTitle
        

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let DetailedNewsVC = segue.destination as? DetailedNewsViewController,
            let cell = sender as? UITableViewCell,
            let cellIndexPath = tableView.indexPath(for: cell)?.row
        else { return }

        DetailedNewsVC.newsTitle = newsArray[cellIndexPath].newsTitle
        DetailedNewsVC.newsBody = newsArray[cellIndexPath].newsBody
        DetailedNewsVC.newsImage = newsArray[cellIndexPath].newsImage
    }
}
