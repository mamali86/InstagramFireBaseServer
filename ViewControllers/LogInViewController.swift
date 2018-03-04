//
//  LogInViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 04/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an Account?  Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignup() {
        
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    
    
}
