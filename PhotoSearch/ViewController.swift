//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by  Hao Chen on 6/27/17.
//  Copyright © 2017 HaoChen. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let reusableId = "PhotoCell"
    let imageManager = PHImageManager()
    let thumbnailSize = CGSize(width: 120, height: 120)
    
    @IBOutlet weak var collectionView: UICollectionView!
    var fetchResults : PHFetchResult<PHAsset>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchResults = PHAsset.fetchAssets(with: options)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath) as! PhotoCell
        let asset = fetchResults.object(at: indexPath.row)
        cell.assetId = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFit, options: nil) { (image, _) in
            // In case the cell is recycled
            if cell.assetId == asset.localIdentifier && (image != nil) {
                cell.imageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return thumbnailSize
    }
}

