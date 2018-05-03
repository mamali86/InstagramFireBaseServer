//
//  SearchViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 02/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    let cellID = "cellID"
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter username"
        searchBar.barTintColor = .gray
        searchBar.delegate = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        collectionView?.register(searchCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.alwaysBounceVertical = true
        
        fetchUsers()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText.isEmpty {
            
            filteredUsers = user
        }
        else {
        
        self.filteredUsers = self.user.filter { (user) -> Bool in
            return (user.username?.lowercased().contains(searchText.lowercased()))!
        }
        }

        self.collectionView?.reloadData()
    }
    
    
    var filteredUsers = [UserInfo]()
    var user = [UserInfo]()
    fileprivate func fetchUsers() {
        
        Database.database().reference().child("users").observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else {return}
                let user = UserInfo(uid: key, dictionary: dictionary)
                self.user.append(user)
            })
            
            self.user.sort(by: { (user1, user2) -> Bool in
                
                return user1.username?.compare(user2.username ?? "") == .orderedAscending
                
            })
            
            self.filteredUsers = self.user
            self.collectionView?.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! searchCell
        cell.user = filteredUsers[indexPath.item]
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)

    }
    
    
    
    
    
}
