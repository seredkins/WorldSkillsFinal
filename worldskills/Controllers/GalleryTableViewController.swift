//
//  GalleryTableViewController.swift
//  worldskills
//
//  Created by ladmin on 16.02.2018.
//  Copyright © 2018 ladmin. All rights reserved.
//

import UIKit
import Firebase

class GalleryTableViewController: UITableViewController {

    var photoes = [UIImage]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var defaultImage  = UIImage()
    
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
        minPhotoRef.getData(maxSize: 50 * 1024 * 1024)
        { (data, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                guard let image = UIImage(data: data!) else {
                    print("I cant cast this mess as [UIImage] :(")
                    return
                }
                self.defaultImage = image
            }
        }
        
        
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.imageView?.image = defaultImage
        cell.indentationWidth = 100.0
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detVC = segue.destination as? SMPViewController,
            let cell = sender as? UITableViewCell else { return }
        
        detVC.image = photoes[tableView.indexPath(for: cell)!.row]
    }
}

