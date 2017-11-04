//
//  utils.swift
//  athena-ios
//
//  Created by AnnatarHe on 02/10/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//


class Utils {
    public static func getRealImageSrc(image: String, type: String = "bmiddle") -> String {
        
        #if DEBUG
            return "https://via.placeholder.com/350x150"
        #endif
        if (image.hasPrefix("http")) {
            return image
        }
        return "https://wx1.sinaimg.cn/\(type)/\(image)"
       
        
    }
}
