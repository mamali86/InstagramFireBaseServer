//
//  Comment.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

struct Comment {
    
    var user: UserInfo
    let text: String?
    let uid: String?
    
    init(user: UserInfo, dictionary: [String: Any]) {
        
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid =  dictionary["uid"] as? String ?? ""
    }
    
    
}
