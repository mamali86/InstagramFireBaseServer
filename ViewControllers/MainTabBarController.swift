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


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        if index == 2 {
            let plusViewController = PlusViewController(collectionViewLayout: UICollectionViewFlowLayout())
            let navController = UINavigationController(rootViewController: plusViewController)
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let LogInController = LogInViewController()
                let navController = UINavigationController(rootViewController: LogInController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        setupControllers()
    }
    
    func setupControllers(){
        
        let homeViewController = setUpNavigationController(image: #imageLiteral(resourceName: "home_unselected"), selectedImage:#imageLiteral(resourceName: "home_selected").withRenderingMode(.alwaysOriginal), rootViewController: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))
       let searchViewController = setUpNavigationController(image: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal))
       let plusViewControler = setUpNavigationController(image: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected").withRenderingMode(.alwaysOriginal))
       let likeViewController = setUpNavigationController(image: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal))
        let userProfileController = setUpNavigationController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected").withRenderingMode(.alwaysOriginal), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
    viewControllers = [homeViewController, searchViewController, plusViewControler, likeViewController, userProfileController]
        
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    
    }
    
    
    func setUpNavigationController(image: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        return navController
        
    }
    
    
    
    
    
}
