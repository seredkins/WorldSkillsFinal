//
//  DetailedCompetitionViewController.swift
//  WorldSkills
//
//  Created by ladmin on 14.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import MapKit

class DetailedCompetitionViewController: UIViewController {

    var name, block, address, desc: String?
    var image: UIImage?
    var location: [Double]?
    
    var textToShare: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func share(_ sender: UIButton) {        
        textToShare = "Hey! Check this competition out! \n \(name!) \n \(desc!) \n It is at \(address!)"
        performSegue(withIdentifier: "toShareScreen", sender: self)
    }
    @IBAction func goToMap(_ sender: UIButton) {
        performSegue(withIdentifier: "toMapScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        blockLabel.text = "Block: \(block!)"
        addressLabel.text = "Address: \(address!)"
        descriptionTextView.text = desc
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let shareMenuVC = segue.destination as? ShareViewController {
            shareMenuVC.generatedText = textToShare
        } else if let mapScreen = segue.destination as? MapViewController {
            mapScreen.destinationLocation = location
            mapScreen.competitionTitle = name
            mapScreen.competitionImage = image
            mapScreen.address = address
        }
    }

}
