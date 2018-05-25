//
//  homeCell.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 29/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

protocol homeCellDelegate {
    func didTapComment(post: captionPost)
}

class homeCell: UICollectionViewCell {
    
    var delegate: homeCellDelegate?
    
    var post: captionPost? {
        
        didSet{
            guard let postImageUrl = post?.postImageUrl else {return}
            postImage.loadImage(urlstring: postImageUrl)
            userNameLabel.text = post?.user?.username
            guard let profleImage = post?.user?.profileImageUrl else {return}
            profileImageView.loadImage(urlstring: profleImage)
//            captionLabel.text = post?.caption
            setupCaptionText()
            
        }
    }
    
    
    
    fileprivate func setupCaptionText(){
        guard let post = self.post else{return}
        guard let username = post.user?.username else {return}
        let captionPost = post.caption
        
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
        let attributedText = NSMutableAttributedString(string: username, attributes: attributes)
        attributedText.append(NSAttributedString(string: " \(captionPost)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        let creationsDate = post.postDate.timeAgoDisplay()
        attributedText.append(NSAttributedString(string: creationsDate, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
    
         captionLabel.attributedText = attributedText
//         captionLabel.text = post?.caption

        
    }
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let profileImageView: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 40 / 2
        image.clipsToBounds = true
        image.backgroundColor = .red

        return image
        
    }()
    
    let postImage: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return button
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    let ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
//        label.text = "STH for now"
  
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(profileImageView)
        addSubview(postImage)
        addSubview(userNameLabel)
        addSubview(optionsButton)
        addSubview(ribbonButton)
        addSubview(captionLabel)


        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        postImage.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        userNameLabel.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 80, height: 40)
        optionsButton.anchor(top: profileImageView.topAnchor, left: nil, bottom: postImage.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        
        ribbonButton.anchor(top: postImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 50)
        
       setUpActionButtons()
        
        captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
    }
    
    
    @objc fileprivate func handleComment() {
        
        guard let post = post else {return}
        delegate?.didTapComment(post: post)
    
    }
    
    fileprivate func setUpActionButtons() {
    
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.anchor(top: postImage.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}









