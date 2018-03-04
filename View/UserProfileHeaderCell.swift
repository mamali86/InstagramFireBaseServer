//
//  UserProfileHeaderCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeaderCell: UICollectionViewCell {
    
    var user: UserInfo? {
    didSet {
     setProfileImage()
        usernameLabel.text = user?.username
    }
    }
    
    
    fileprivate func setProfileImage() {
        
        guard let profileImageUrl = user?.profileImageUrl else {return}
        guard let url = URL(string: profileImageUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print("Could not fecth image data", err)
            }
            
            guard let data = data else {return}
            let imageToCache = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImage.image = imageToCache
            }
            
            }.resume()
    }
    
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
        
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    let bookMarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])

        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImage)
        profileImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        profileImage.layer.cornerRadius = 80 / 2
        profileImage.clipsToBounds = true
         setupBottomToolbar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImage.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        
    setUpUsersStatsView()
        
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 2, paddingLeft: 20, paddingBottom: 0, paddingRight: -13, width: 0, height: 34)
    }
    
    
    fileprivate func setUpUsersStatsView() {
        
        let stackView = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 0, paddingRight: 6, width: 0, height: 50)
        stackView.distribution = .fillEqually
  
        
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookMarkButton])
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        stackView.distribution = .fillEqually
        
         bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
