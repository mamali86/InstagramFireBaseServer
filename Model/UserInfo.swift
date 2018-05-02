//
//  User.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

struct UserInfo {
    
    let username: String?
    let profileImageUrl: String?
    let uid: String?
    
    
    init(uid: String, dictionary :[String: Any]) {
        
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = uid
        
    }
}
