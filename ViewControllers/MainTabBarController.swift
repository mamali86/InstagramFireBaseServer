//
//  MainTabBarController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 27/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let LogInController = LogInViewController()
                let navController = UINavigationController(rootViewController: LogInController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        let redVC = UserProfileViewController(collectionViewLayout: layout)
    
        let NavController = UINavigationController(rootViewController: redVC)
        tabBar.tintColor = .black
        NavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        NavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        viewControllers = [NavController, UIViewController()]
    }
}
