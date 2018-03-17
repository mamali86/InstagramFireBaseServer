//
//  UserProfileViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 27/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase


class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let cellId = "cellID"
    var user: UserInfo?
    var posts =  [captionPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(postCell.self, forCellWithReuseIdentifier: cellId)
        setUpNavigationItems()
        fetchUsers()
        uploadPost()
    }
    
    fileprivate func setUpNavigationItems() {
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(#imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        
    }
    
    
    @objc func handleLogOut() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
            try Auth.auth().signOut()
            } catch let logOutERROR {
                print("Error Logging Out", logOutERROR)
            }
            let LogInController = LogInViewController()
            let navController = UINavigationController(rootViewController: LogInController)
            self.present(navController, animated: true, completion: nil)
            
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! postCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeaderCell
     
        header.user = self.user
        return header
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    fileprivate func fetchUsers(){
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            self.user = UserInfo(dictionary: dictionary)
            self.navigationItem.title =  self.user?.username
            
            self.collectionView?.reloadData()
        }) { (err) in
            print("failed to fetch the user",err)
        }
    }
    
    fileprivate func uploadPost(){
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("Caption").child(currentUserID).observeSingleEvent(of: .value) { (post) in
            
            guard let dictionary = post.value as? [String: Any] else {return}
            
            
            self.posts.append(captionPost(dictionary: dictionary))
            self.collectionView?.reloadData()
            
        
        }
    
    }
    
    
    
}



