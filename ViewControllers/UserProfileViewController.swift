//
//  UserProfileViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 27/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase


class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, userProfileHeaderDelegate {

    
    let headerId = "headerId"
    let cellId = "cellID"
    let listCellId = "listCellId"
    var isGridView = true
    
    var user: UserInfo?
    var posts =  [captionPost]()
    var isFinishedPaging = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(postCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(homeCell.self, forCellWithReuseIdentifier: listCellId)
        
        setUpNavigationItems()
        fetchUsers()
    }
    
    
    fileprivate func dataPagination() {
        
        guard let currentUserID = self.user?.uid else {return}
        
        let ref = Database.database().reference().child("Caption").child(currentUserID)
        var querry = ref.queryOrderedByKey()
        
        if posts.count > 0 {
        let value = self.posts.last?.id
        querry = querry.queryStarting(atValue: value).queryLimited(toFirst: 2)
        }
        
        querry.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let user = self.user else {return}
            
            var allObjects = snapshot.children.allObjects as! [DataSnapshot]
            
            if allObjects.count < 2 {
                
                self.isFinishedPaging = true
            }
            
            if self.posts.count > 0 {

            allObjects.removeFirst()
            
            }
            allObjects.forEach({ (snapShot) in
                
                guard let dictionary = snapShot.value else {return}
                var post = captionPost(user: user, dictionary: dictionary as! [String : Any])
                post.id = snapShot.key
                
                self.posts.append(post)
                self.collectionView?.reloadData()
            })
            

            
        }) { (err) in
            
            print("failed to fetch posts through pagination", err)
        }
        
    }
    
    fileprivate func fetchOrderedPosts() {
    
        guard let currentUserID = self.user?.uid else {return}
        let ref = Database.database().reference().child("Caption").child(currentUserID)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}

            guard let user = self.user else {return}
            let post = captionPost(user: user, dictionary: dictionary)
            self.posts.insert(post, at: 0)

//            self.posts.append(post)
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("failed to fetch posts orderly", err)
        }
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
        
        
        if indexPath.item < self.posts.count - 1 && !isFinishedPaging {
            dataPagination()
          
        }
        
        if isGridView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! postCell
            
            cell.post = posts[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as! homeCell
            
            cell.post = posts[indexPath.item]
            return cell
            
        }
        
    
            
    }
    
    func didTapListView() {
        isGridView = false
        collectionView?.reloadData()
    }
    
    
    func didTapGridView() {
        isGridView = true
        collectionView?.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)

            
        } else {
            var height: CGFloat = 40 + 8 + 8
            height += view.frame.width
            height += 50
            height += 80
            
            return CGSize(width: view.frame.width, height: height)
        }
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
        
        header.delegate = self
        return header
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    fileprivate func fetchUsers(){
        
        let userID = user?.uid ?? (Auth.auth().currentUser?.uid ?? "")
    
        Database.getUserInfo(uid: userID) { (user) in
            self.user = user
            self.navigationItem.title =  user.username
            self.collectionView?.reloadData()
//            self.fetchOrderedPosts()
            
            
            self.dataPagination()
            

        }


    }
    
}



