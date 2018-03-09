//
//  PlusViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 08/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//


import UIKit
import Photos

class PlusViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let headerID = "headerID"
    let cellID = "cellID"
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .red
        collectionView?.register(imageSelectionCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        fetchImages()
        setUpNavigationBarItems()
    }
    
    
    fileprivate func fetchImages() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 8
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let imagesAndVideos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        imagesAndVideos.enumerateObjects { (object, count, stop) in
            
            let manager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            manager.requestImage(for: object, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image,info) in
                
                guard let image = image else {return}
               self.images.append(image)
                
            })

            
        }
        
        

        
    }
    
    fileprivate func setUpNavigationBarItems() {
        
        navigationController?.navigationBar.tintColor = .black
      
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleNext() {
        print("Next")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        header.backgroundColor = .yellow
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! imageSelectionCell
        let image = self.images[indexPath.item]
        cell.selectionImage.image = image
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
