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
            
            commentLabel.text = comment?.text
            
        }

    }
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(commentLabel)
        commentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
