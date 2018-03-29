//
//  homeViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    var posts = [captionPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       collectionView?.backgroundColor = .white
       collectionView?.register(homeCell.self, forCellWithReuseIdentifier: cellID)
       setUpNavigationItems()
        fecthPost()
        
}
    
    
    fileprivate func setUpNavigationItems() {
    
    navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    fileprivate func fecthPost(){
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("Caption").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            print(dictionaries)
            
            dictionaries.forEach({ (key,value) in
                
                guard let dictionary = value as? [String: Any] else {return}
                let post = captionPost(dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.collectionView?.reloadData()
        }
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! homeCell
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}