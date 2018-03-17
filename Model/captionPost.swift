//
//  captionPost.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 17/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import Foundation


struct captionPost {
    
    var postImageUrl: String
    
    
    init(dictionary: [String: Any]) {
        
        self.postImageUrl = dictionary["ImageUrl"] as? String ?? ""
        
        
    }
}
