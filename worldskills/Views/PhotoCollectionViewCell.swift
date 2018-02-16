//
//  PhotoCollectionViewCell.swift
//  worldskills
//
//  Created by ladmin on 16.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var fullPicture: UIImage?
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            guard let collVC = self.superview as? UICollectionView else { return }
            collVC.reloadData()
        }
    }
}
