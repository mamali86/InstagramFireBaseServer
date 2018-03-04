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
    
    
    init(dictionary :[String: Any]) {
        
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
}
