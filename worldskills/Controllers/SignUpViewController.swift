//
//  SignUpViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confimPasswordField: UITextField!
    
    @IBAction func trySignUp(_ sender: UIButton) {
        guard let email = emailField.text,
            let password = passwordField.text,
            passwordField.text == confimPasswordField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toNewsScreen", sender: self)
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
