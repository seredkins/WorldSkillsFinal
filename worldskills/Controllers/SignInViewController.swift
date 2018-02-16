//
//  SignInViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func trySignIn(_ sender: UIButton) {
        guard let email = emailField.text,
            let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toNewsScreen", sender: self)
                }
            } else {
                print("\(error?.localizedDescription)")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
