//
//  setImage.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 20/03/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    
        func loadImage(urlstring: String) {
            
            if let cachedImage = imageCache[urlstring] {
                self.image = cachedImage
                return 
                
            }
            lastURLUsedToLoadImage = urlstring
            
            guard let url = URL(string: urlstring) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Could not fecth postImage data",err)
                }
                
                
                if url.absoluteString != self.lastURLUsedToLoadImage {

                    return
                }
                
                guard let data = data else {return}
                guard let imageToCache = UIImage(data: data) else {return}
                imageCache[url.absoluteString] = imageToCache
                
                
                
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
                
                }.resume()
}

}
    

