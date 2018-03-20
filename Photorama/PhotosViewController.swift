//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Robert Argume on 2018-03-12.
//  Copyright © 2018 Robert Argume. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos(){
            (photosResult) ->Void in

            switch photosResult {
            case let .success(photos):
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
                print("Successfu11y found \(photos.count) photos.")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer:0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        let photo = photoDataSource.photos[indexPath.row]
        store.fetchImage(for: photo) { (result) -> Void in
            guard let photolndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
                    
            }
            let photolndexPath = IndexPath(item: photolndex, section: 0)
            
            if let cell = self.collectionView.cellForItem(at: photolndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "DetailScreen"{
//            var vc = segue.destinationViewController as! DetailsViewController
//            vc.data = ""
//            
//        }
//    }
}




