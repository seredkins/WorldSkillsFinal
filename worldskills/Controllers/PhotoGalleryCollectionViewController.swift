//
//  PhotoGalleryCollectionViewController.swift
//  worldskills
//
//  Created by ladmin on 16.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class PhotoGalleryCollectionViewController: UICollectionViewController {
    
    var photoes = [UIImage]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storage = Storage.storage()
        
        let storageRef = storage.reference(forURL: "gs://worldskills-f6-1.appspot.com/galery/")
        
        
        var refs = [StorageReference]()
        
        refs.append(storageRef.child("f6_news_2.jpg"))
        
        refs.append(storageRef.child("IMG_0425.JPG"))
        refs.append(storageRef.child("IMG_0445.JPG"))
        refs.append(storageRef.child("IMG_0451.JPG"))
        refs.append(storageRef.child("IMG_0452.JPG"))
        refs.append(storageRef.child("IMG_0454.JPG"))
        
//        refs.append(storageRef.child("klYrY5VtpbRpK94oxj1GlA6cgVh1_image_69.jpeg"))
        refs.append(storageRef.child("POSTMAN_SCREENSHOT.png"))
        
        let minPhotoRef = storageRef.child("thumbnail.jpg")
        
        for ref in refs {
            ref.getData(maxSize: 50 * 1024 * 1024)
            { (data, error) in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                } else {
                    guard let image = UIImage(data: data!) else {
                        print("I cant cast this mess as [UIImage] :(")
                        return
                    }
                    self.photoes.append(image)
                }
            }
        }
        
        
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        
        let subV = UIImageView()
        subV.image = photoes[indexPath.row]
        cell.backgroundView?.addSubview(subV)
        
        
        return cell
    }
    
    


//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }

}
