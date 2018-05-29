//
//  CommentCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet{
            
            
            guard let profileImageUrl = comment?.user?.profileImageUrl else {return}
            profileImage.loadImage(urlstring: profileImageUrl)
            
            guard let username = comment?.user?.username else {return}
            let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
            let attributedText = NSMutableAttributedString(string: username, attributes: attributes)
            guard let commentText = comment?.text else {return}
            
            attributedText.append(NSMutableAttributedString(string: " " + commentText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            commentLabel.attributedText = attributedText
            
        }
    }
    
    
    let profileImage: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .blue
        image.clipsToBounds = true
        return image
        
    }()
    
    
    let commentLabel: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(commentLabel)
        addSubview(profileImage)

    
        commentLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: commentLabel.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 40, height: 40)
        profileImage.layer.cornerRadius = 40/2
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
