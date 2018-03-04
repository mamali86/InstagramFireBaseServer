//
//  RouteManager.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 19/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

final class RouteManager {
    
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func loadViewController<A: UIViewController>(type: A.Type) -> A {
        
//        guard let viewController = ViewController() as? A else {
//            fatalError("ViewController identifier incorrect")
//
//        }
        
        guard let viewController = MainTabBarController() as? A else {
            fatalError("ViewController identifier incorrect")
            
        }
        
        return viewController
        
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
    }
    
    func startWithViewController() {
     setRootViewController(UINavigationController(rootViewController: instantiateViewController()))
        
    }
    
    
    func startWithMainTabBarController() {
        setRootViewController(instantiateMainTabBarController())
        
    }
    
    
    func instantiateViewController() -> SignUpViewController {
          let viewController = loadViewController(type: SignUpViewController.self)
        return viewController
    }
    

    func instantiateMainTabBarController() -> MainTabBarController {
        let viewController = loadViewController(type: MainTabBarController.self)
        return viewController
    }
    
    
    
    
    
    
}
