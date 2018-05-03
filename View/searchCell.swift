//
//  searchCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 02/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit


class searchCell: UICollectionViewCell {

    var user: UserInfo? {
        didSet{
            
            usernameLabel.text = user?.username
            
            guard let profileImageUrl = user?.profileImageUrl else {return}
            profileImage.loadImage(urlstring: profileImageUrl)
            
        }
    }
    
    let profileImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 50 / 2
        return image
        
    }()
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(profileImage)
        profileImage.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
