//
//  FBSDK.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 02/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

extension Database {

    static func getUserInfo(uid: String, completion: @escaping (UserInfo) -> ())  {
    
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snap) in
        guard let dictionary = snap.value as? [String: Any] else {return}
        let user = UserInfo(uid: uid, dictionary: dictionary)
        completion(user)

}
//            { (err) in
//                print("failed to fetch the user",err)
//        }
    }
    
}
