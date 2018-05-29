//
//  Comment.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 28/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

struct Comment {
    
    let text: String?
    let uid: String?
    
    init(dictionary: [String: Any]) {
        
        self.text = dictionary["text"] as? String ?? ""
        self.uid =  dictionary["uid"] as? String ?? ""
    }
    
    
}
