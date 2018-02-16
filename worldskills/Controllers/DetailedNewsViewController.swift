//
//  DetailedNewsViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {
    
    var newsTitle: String?
    var newsBody: String?
    var newsImage: UIImage?
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleLabel.text = newsTitle
        bodyTextView.text = newsBody
        newsImageView.image = newsImage
        
        bodyTextView.isEditable = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
