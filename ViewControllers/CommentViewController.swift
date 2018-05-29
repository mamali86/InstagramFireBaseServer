//
//  commentViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 25/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase


class CommentViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var post: captionPost?
    var comments = [Comment]()
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        collectionView?.backgroundColor = .red
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: cellID)
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    let commentTextFiled: UITextField = {
        let commentField = UITextField()
        commentField.placeholder = "Comment here"
        return commentField
        
    }()
    
    let submitButton: UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("Send", for: .normal)
        Button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return Button
        
    }()
    
    @objc func handleSubmit() {

        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let dictionaryValue = ["text": commentTextFiled.text ?? "", "CreationDate": Date().timeIntervalSince1970, "uid": uid] as [String : Any]
        guard let postID = post?.id else{return}
        Database.database().reference().child("Comment").child(postID).childByAutoId().updateChildValues(dictionaryValue) { (err, ref) in
            if let err = err {
                print("Failed to save comment info into db", err)
                return
            }

        }

    }
    
    fileprivate func fetchComments() {
        guard let postID = post?.id else{return}
        guard let uid = Auth.auth().currentUser?.uid else {return}

        Database.database().reference().child("Comment").child(postID).observe(.childAdded, with: { (snapshot) in
            guard let commentsDictionary = snapshot.value as?[String: Any] else {return}
            var comment = Comment(dictionary: commentsDictionary)
            
            let user = Database.getUserInfo(uid: uid, completion: { (user) in
                comment.user = user
                self.comments.append(comment)
                self.collectionView?.reloadData()
            })
           
        }) { (err) in
            print("Failed to observe Comments", err)
        }
        

    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        containerView.addSubview(commentTextFiled)
        containerView.addSubview(submitButton)

        commentTextFiled.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 0, height: 0)
        
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 50, height: 0)
        
        return containerView
        
    }()

    override var inputAccessoryView: UIView? {
        get {
        return containerView
        }
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
