//
//  captionViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 12/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit


class captionViewController: UIViewController {
    
    var selectedImageCaption: UIImage? {
    
    didSet{
      imageCaption.image = selectedImageCaption
    }
    }
    
    let imageCaption: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        
    }()
    
    
    
    let captionTextView: UITextView = {
        let captionTextView = UITextView()
        return captionTextView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 100)
        
        
        containerView.addSubview(imageCaption)
        imageCaption.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        
        containerView.addSubview(captionTextView)
        captionTextView.anchor(top: containerView.topAnchor, left: imageCaption.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 150, height: 0)
        
    }

    
    
     @objc func handleShare(){
        
        
    }
    
    
}
