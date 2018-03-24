//
//  utils.swift
//  athena-ios
//
//  Created by AnnatarHe on 02/10/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import SKPhotoBrowser
import Sentry

class Utils {
    
    public static func initApp() {

        // FIXME: SKPhotoBrowser bug here.
        // https://github.com/suzuki-0000/SKPhotoBrowser/issues/260
//        SKPhotoBrowserOptions.displayToolbar = true
        SKPhotoBrowserOptions.displayAction = true
        
        do {
            Client.shared = try Client(dsn: "https://c11f932d316c4a2aa7b99e43cd950678:176a95d1d20c48c6b927b922fb44505f@sentry.io/238843")
            try Client.shared?.startCrashHandler()
        } catch let error {
            print("\(error)")
            // Wrong DSN or KSCrash not installed
        }
    }
    
    
    
    public static func getRealImageSrc(image: String, type: String = "bmiddle") -> String {
        
//        #if DEBUG
//            return "https://via.placeholder.com/350x150"
//        #endif
        let realImageUrlData = Data(base64Encoded: image)
        let realImageUrl = String(data: realImageUrlData!, encoding: .utf8)
        if (realImageUrl!.hasPrefix("http")) {
            return image
        }
        return "https://wx1.sinaimg.cn/\(type)/\(image)"
    }
    
    public static func presentBigPreview(
        view: UIViewController,
        src: String,
        holderImage: UIImage?,
        from: UIView
        ) {
        
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(src)
        
        photo.caption = "hello world"
        
        images.append(photo)
        
        let browser = SKPhotoBrowser(originImage: holderImage ?? UIImage(), photos: images, animatedFromView: from)
        
        browser.initializePageIndex(0)
        
        view.present(browser, animated: true, completion: nil)
        
    }
}

struct AthenaColors {
    static let green = UIColor.init(red: 0.80, green: 0.86, blue: 0.22, alpha: 1)
    static let blue = UIColor.init(red:0.00, green:0.74, blue:0.83, alpha:1.0)
}

