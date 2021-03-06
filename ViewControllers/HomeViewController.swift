//
//  homeViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, homeCellDelegate {

    

    let cellID = "cellID"
    var posts = [captionPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       collectionView?.backgroundColor = .white
       collectionView?.register(homeCell.self, forCellWithReuseIdentifier: cellID)
       setUpNavigationItems()
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cameraView))
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(self, selector: #selector(retreiveNewPost), name: captionViewController.updateNotificationName, object: nil)
        
       fetchAllPosts()
}

    func didTapComment(post: captionPost) {
        
        let commentViewController = CommentViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        commentViewController.post = post
        navigationController?.pushViewController(commentViewController, animated: true)
        
    }
    
    
    @objc func cameraView(){
        
        
        let cameraViewController = CameraViewController()
      present(cameraViewController, animated: true, completion: nil)
    }
    
    
    @objc func retreiveNewPost(){
    
        
    handleRefresh()
    }
    
    @objc fileprivate func handleRefresh(){
        
        posts.removeAll()
        fetchAllPosts()
        
    }
    
    func didLike(for cell: homeCell) {
        
        guard let indexPath = collectionView?.indexPath(for: cell) else {return}
        var post = posts[indexPath.item]
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postID = post.id else{return}

        let dictionaryValue = [uid: post.hasliked == true ? 0 : 1]
        
        Database.database().reference().child("Likes").child(postID).updateChildValues(dictionaryValue) { (err, ref) in
                    if let err = err {
                        print("Failed to save like info into db", err)
                        return
                    }
            post.hasliked = !post.hasliked
            
            self.posts[indexPath.item] = post
            self.collectionView?.reloadItems(at: [indexPath])
                }
    }
    
    fileprivate func fetchAllPosts(){
        fetchPost()
        fetchHomeFeed()
    }
    
    fileprivate func fetchHomeFeed(){
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("Following").child(currentUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let followingDoctionary = snapshot.value as? [String: Any] else {return}
            
            followingDoctionary.forEach({ (key, value) in
                
                Database.getUserInfo(uid: key) { (user) in
                    self.fetchUserPosts(user: user)
                }
                
            })
            
        }) { (err) in
            print("Error Finding Followers")
        }
    
    
    }
    
    fileprivate func setUpNavigationItems() {
    
    navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    
    fileprivate func fetchPost(){
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Database.getUserInfo(uid: currentUserID) { (user) in
            self.fetchUserPosts(user: user)

        }
    }
    
    
    fileprivate func fetchUserPosts(user: UserInfo){
        
        guard let uid = user.uid else {return}

        Database.database().reference().child("Caption").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                
                guard let dictionaries = snapshot.value as? [String: Any] else {return}
            
            
            self.collectionView?.refreshControl?.endRefreshing()
                dictionaries.forEach({ (key,value) in
                    guard let dictionary = value as? [String: Any] else {return}

                    var post = captionPost(user: user, dictionary: dictionary)
                    post.id = key
                    
                    guard let currentUid = Auth.auth().currentUser?.uid else {return}
                    Database.database().reference().child("Likes").child(key).child(currentUid).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        
                        if let value = snapshot.value as? Int, value == 1 {
                            post.hasliked = true
                        }
                        else{
                            post.hasliked = false
                        }
                        
                        self.posts.append(post)
                        //Ordering Posts
                        self.posts.sort(by: { (p1, p2) -> Bool in
                            return p1.postDate.compare(p2.postDate) == .orderedDescending

  })
                        self.collectionView?.reloadData()

                        
                    }, withCancel: { (err) in
              
                            print("Failed to fetch like info for post", err)

                    })


            })

            }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! homeCell
        
        if indexPath.item < posts.count {
            cell.post = posts[indexPath.item]
            
        }
        
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 80
        
        return CGSize(width: view.frame.width, height: height)
    }
}
