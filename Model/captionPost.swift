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
    var user: UserInfo?
    let caption: String
    let postDate: Date
    var id: String?
    var hasliked = false
    
    
    init(user: UserInfo, dictionary: [String: Any]) {
        
        self.postImageUrl = dictionary["ImageUrl"] as? String ?? ""
        self.user = user
        self.caption = dictionary["captionText"] as? String ?? ""
        let date =  dictionary["creationDate"] as? Double ?? 0
        self.postDate = Date(timeIntervalSince1970: date)
    }
}
