//
//  DetailsViewController.swift
//  Photorama
//
//  Created by Robert Argume on 2018-03-19.
//  Copyright © 2018 Robert Argume. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController{
    
    @IBOutlet weak var photoImage: UIImageView!
    var store: PhotoStore!
    var receivedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = try? Data(contentsOf: (receivedPhoto?.remoteURL)!)
        {
            self.photoImage.contentMode = .scaleAspectFit
             self.photoImage.image = UIImage(data: data)
        }
       
        //updateImageView(for: receivedPhoto!)
    }
    
    func updateImageView(for photo: Photo) {
        
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.photoImage.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
            
        }
        
    }
    
    
    
}
