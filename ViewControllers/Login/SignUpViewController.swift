//
//  ViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 19/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let haveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Have an Account? ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
    
        button.addTarget(self, action: #selector(handlePopSignUpScreen), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handlePopSignUpScreen() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(HandleImagePlus), for: .touchUpInside)
        
        return button
    }()
    

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    
    @objc func HandleImagePlus() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            addImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        else if let editedImage = info["UIImagePickerEditedImage"] as? UIImage {
            addImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        addImageButton.layer.cornerRadius = addImageButton.frame.width / 2
        addImageButton.layer.masksToBounds = true
        addImageButton.layer.borderColor = UIColor.black.cgColor
        addImageButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func handleTextChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        if isFormValid {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
        else {
           signUpButton.isEnabled = false
           signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
     
    }
    
    @objc func handleSignUp() {
        
        guard let email = emailTextField.text, email.count > 0  else {return}
        guard let username = usernameTextField.text, username.count > 0  else {return}
        guard let password = passwordTextField.text, password.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?,error: Error?) in
            
            if let err = error {
                print("Error detected", err)
            }
            
            print("Successfully created the user:", user?.uid ?? "")
            guard let image = self.addImageButton.imageView?.image else {return}
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            let filename = NSUUID().uuidString
            Storage.storage().reference().child(filename).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let err = error {
                    print("Failed to upload user profile image into db", err)
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                 print("successfully uploaded profile image", profileImageUrl)
                
                            guard let uid = user?.uid else {return}
                
                            let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                            let values = [uid : dictionaryValues]
                
                            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                                if let err = error {
                                    print("Failed to save user info into db", err)
                                    return
                                }
                
                                print("successfully saveed user info into db")
                
                            })
                
            })
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupviews()
        
        
        view.addSubview(haveAnAccountButton)
        haveAnAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
      }
    
    
    fileprivate func setupviews(){
        
        view.addSubview(addImageButton)
        addImageButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)

        addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 5),
//            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
//            stackView.heightAnchor.constraint(equalToConstant: 200)
//            ])
        
        stackView.anchor(top: addImageButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 200)
    }

    
}
    extension UIView {
        
        func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
            }
            
            if let right = right {
                self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
            }
            
            if width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            
            
            
        }
    }



