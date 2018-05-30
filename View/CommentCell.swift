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
            
            guard let profileImageUrl = comment?.user.profileImageUrl else {return}
            profileImage.loadImage(urlstring: profileImageUrl)
            
            guard let username = comment?.user.username else {return}
            let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
            let attributedText = NSMutableAttributedString(string: username, attributes: attributes)
            guard let commentText = comment?.text else {return}
            
            attributedText.append(NSMutableAttributedString(string: " " + commentText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            commentTextView.attributedText = attributedText
            
        }
    }
    
    
    let profileImage: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        
    }()
    
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false 
        return textView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(commentTextView)
        addSubview(profileImage)

        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 40, height: 40)
        
        commentTextView.anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
      
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
