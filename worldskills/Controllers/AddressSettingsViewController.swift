//
//  AddressSettingsViewController.swift
//  worldskills
//
//  Created by ladmin on 16.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class AddressSettingsViewController: UIViewController {
    
    var strForKolhozArr = String()

    @IBOutlet weak var isFavouriteSwitchControll: UISwitch! {
        didSet {
            if isFavouriteSwitchControll.isOn {
                kolhozArr.append(strForKolhozArr)
            } else {
//                kolhozArr.remove(at: kolhozArr.)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFavouriteSwitchControll.isOn = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
