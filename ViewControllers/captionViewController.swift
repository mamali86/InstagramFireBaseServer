//
//  captionViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 12/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

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
        
        
        guard let captionText = self.captionTextView.text, captionTextView.text.count > 0  else {return}
        guard let image = self.selectedImageCaption else {return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
        
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("Caption").child(filename).putData(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                 print("Failed to upload user profile image into db", err)
            }
            
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let captionImage = metadata?.downloadURL()?.absoluteString else {return}
            print("successfully uploaded profile image", captionImage)
            
            let dictionaryValues = ["ImageUrl": captionImage, "captionText": captionText, "imageWidth": image.size.width, "imageHeight": image.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
            Database.database().reference().child("Caption").child(uid).childByAutoId().updateChildValues(dictionaryValues, withCompletionBlock: { (err, ref) in
                if let err = error {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to save user info into db", err)
                    return
                }
            })
        }
        
        
       dismiss(animated: true, completion: nil)
        
        
        
    }
}
