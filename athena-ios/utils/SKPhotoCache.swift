//
//  SKPhotoCache.swift
//  athena-ios
//
//  Created by le.he on 2018/4/5.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import Foundation
import SKPhotoBrowser
import SDWebImage

class CustomImageCache: SKImageCacheable {
    func removeAllImages() {
        // TODO
    }
    
    func imageForKey(_ key: String) -> UIImage? {
        return SDImageCache.shared.imageFromCache(forKey: key)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        SDImageCache.shared.store(image, forKey: key, toDisk: true, completion: nil)
    }
    
    func removeImageForKey(_ key: String) {
        SDImageCache.shared.removeImage(forKey: key)
    }
}
