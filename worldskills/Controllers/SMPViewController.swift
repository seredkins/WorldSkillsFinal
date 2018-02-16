//
//  SMPViewController.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class SMPViewController: UIViewController, UIScrollViewDelegate {
    
    var image = UIImage()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
    }
}
