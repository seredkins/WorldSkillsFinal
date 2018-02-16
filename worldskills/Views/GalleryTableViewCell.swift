//
//  GalleryTableViewCell.swift
//  worldskills
//
//  Created by ladmin on 16.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView! {
        didSet {
            guard let tableView = self.superview as? UITableView else { return }
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
