//
//  ImageCache.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit

/// Image Cache class which could be used by the network data manager class to persist/retrieve image data
class ImageCache {
    
    private let cache = NSCache<NSString, UIImage>()
    
    init(){
        self.cache.countLimit = 20
    }
    
    func retrieveFromCache(urlString: NSString) -> UIImage? {
        if let cachedImage = self.cache.object(forKey: urlString ){
            return cachedImage
        } else {
            return nil
        }
    }
    
    func storeImageInCache(image: UIImage, urlString: NSString) {
        self.cache.setObject(image, forKey: urlString)
    }
    
}
