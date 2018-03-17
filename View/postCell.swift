//
//  postCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 17/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class postCell: UICollectionViewCell {
    
    var post: captionPost? {
        didSet{
            
            setPostImage()
        }
    }
    
    
    fileprivate func setPostImage() {
    
        
        guard let postImageUrl = post?.postImageUrl else {return}
        guard let url = URL(string: postImageUrl) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print("Could not fecth postImage data",err)
            }
            
            guard let data = data else {return}
            guard let imageToCache = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.postImage.image = imageToCache
            }
            
        }.resume()
        
    }
    
    let postImage: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .purple
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image

    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImage)
        postImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
