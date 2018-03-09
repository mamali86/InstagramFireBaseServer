//
//  imageSelectionCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 09/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

class imageSelectionCell: UICollectionViewCell {
    
    
    let selectionImage: UIImageView = {
      let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .purple
        return image
    
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(selectionImage)
        
        selectionImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
