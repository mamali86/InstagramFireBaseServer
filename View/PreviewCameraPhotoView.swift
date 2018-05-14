//
//  PreviewCameraPhotoView.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 14/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Photos

class PreviewCameraPhotoView: UIView {
    
    let previewImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
        
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handelCancel), for: .touchUpInside)
        return button
    }()
    
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handelSave), for: .touchUpInside)
        return button
    }()
    
    
    let saveLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved Successfully"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(white: 0, alpha: 0.3)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    @objc fileprivate func handelCancel() {
    self.removeFromSuperview()
    
    }
    
    @objc fileprivate func handelSave() {
        
        
        guard let previewimg = previewImage.image else {return}
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewimg)
            
        }, completionHandler: { (success, error) in
            if let err = error {
            print("error in saving image", err)
            }
            
            
            DispatchQueue.main.async {
                
                
                self.addSubview(self.saveLabel)
                self.saveLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
                self.saveLabel.center = self.center
                self.addSubview(self.saveLabel)
                self.saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    
                    self.saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        
                        self.saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        self.saveLabel.alpha = 0

                    }, completion: { (_) in
                        
                         self.saveLabel.removeFromSuperview()
                        
                    })
                    
                    
                })
            }
         
            
            
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImage)
        previewImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(cancelButton)
        cancelButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 24, paddingRight: 0, width: 50, height: 50)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
