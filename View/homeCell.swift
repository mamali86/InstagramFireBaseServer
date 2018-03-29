//
//  homeCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 29/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit


class homeCell: UICollectionViewCell {
 
    
    var post: captionPost? {
        
        didSet{
            guard let postImageUrl = post?.postImageUrl else {return}
            
            postImage.loadImage(urlstring: postImageUrl)
            
            
            
        }
        
    }
    
    
    let postImage: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImage)
        postImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}









