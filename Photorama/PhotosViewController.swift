//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Robert Argume on 2018-03-12.
//  Copyright © 2018 Robert Argume. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos(){
            (photosResult) ->Void in
            
            switch photosResult {
            case let .success(photos):
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
                print("Successfu11y found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
    
    func updateImageView(for photo: Photo) {
        
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
            
        }
        
    }
    
}
