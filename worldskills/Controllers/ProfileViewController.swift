//
//  ProfileViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    @IBOutlet weak var favouriteTableView: UITableView!
    
    var email, id: String?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    
    @IBAction func logOut(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "toNewsScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = "Email: \(email!)"
        IDLabel.text = "ID: \(id!)"

        // Do any additional setup after loading the view.
    }
}
