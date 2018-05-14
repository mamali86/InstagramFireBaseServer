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
    var objects = [PHAsset]()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(imageSelectionCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(imageSelectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
//        collectionView?.alwaysBounceVertical = true

        fetchImages()
        setUpNavigationBarItems()
    }
    
    
    fileprivate func fetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 50
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    
    fileprivate func fetchImages() {
        
        let imagesAndVideos = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        
        
        DispatchQueue.global(qos: .background).async {
            
        
        imagesAndVideos.enumerateObjects { (object, count, stop) in
            
            let manager = PHImageManager.default()
            let targetSize = CGSize(width: 200, height: 200)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            manager.requestImage(for: object, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image,info) in
                
                guard let image = image else {return}
               self.images.append(image)
                self.objects.append(object)
                
                if self.selectedImage == nil {
                    self.selectedImage = image
                }
                
                
                if count == imagesAndVideos.count - 1 {
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
                
                
            })

        }
        
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
        
        let capationController = captionViewController()
        capationController.selectedImageCaption = headerRef?.topImage.image
        navigationController?.pushViewController(capationController, animated: true)
        
    }
    

    var headerRef: imageSelectionHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! imageSelectionHeader
        
        
        headerRef.self = header
        
        header.topImage.image = selectedImage

        let manager = PHImageManager.default()
        let targetSize = CGSize(width: 1000, height: 1000)
        if let selectedImage = selectedImage{
            if let index = images.index(of: selectedImage) {
            let selectedHighQualityObject = self.objects[index]
     
        
        
        manager.requestImage(for: selectedHighQualityObject, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
            
            header.topImage.image = image

            
        }
            }
        }
    
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
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        let indexPath = NSIndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
     
        
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
