//
//  ParticipantTableViewCell.swift
//  WorldSkills
//
//  Created by ladmin on 15.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {
    
    var firstname, lastname, role: String?
    var photo: UIImage?
    var imageurl: URL?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView! {
        didSet {
            guard let tableView = self.superview as? UITableView else { return }
            tableView.reloadData()
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
