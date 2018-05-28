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
        let img = SDWebImageManager.shared().imageCache?.imageFromCache(forKey: key)
        return img
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        SDWebImageManager.shared().imageCache?.store(image, forKey: key, toDisk: true, completion: nil)
    }
    
    func removeImageForKey(_ key: String) {
        SDWebImageManager.shared().imageCache?.removeImage(forKey: key, withCompletion: nil)
    }
}
