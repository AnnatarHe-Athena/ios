//
//  utils.swift
//  athena-ios
//
//  Created by AnnatarHe on 02/10/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import SKPhotoBrowser
import Sentry
import SDWebImage

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
        // 2. replace SKCache instance with custom cache
        SKCache.sharedCache.imageCache = CustomImageCache()
    }
    
    
    
    public static func getRealImageSrc(image: String, type: String = "bmiddle") -> String {
        
//        #if DEBUG
//            return "https://via.placeholder.com/350x150"
//        #endif
        let realImageUrlData = Data(base64Encoded: image)
        let realImageUrl = String(data: realImageUrlData!, encoding: .utf8)
        if (realImageUrl!.hasPrefix("http")) {
            return realImageUrl!
        }
        
        if (realImageUrl?.hasPrefix("qn://"))! {
            let qnBaseURL = realImageUrl?.replacingOccurrences(of: "qn://", with: "https://cdn.annatarhe.com/")
            switch (type) {
            case "bmiddle":
                return qnBaseURL! + "-thumbnails.webp"
            case "large":
                return qnBaseURL! + "-copyrightDB"
            default:
                return ""
            }
        }

        return "https://ww1.sinaimg.cn/\(type)/\(realImageUrl!)"
    }
    
    public static func presentBigPreview(
        view: UIViewController,
        src: FetchGirlsQueryQuery.Data.Girl,
        holderImage: UIImage?,
        from: UIView
        ) {
        
        
        let imgSrc = Utils.getRealImageSrc(image: (src.fragments.fetchGirls.img)!, type: "large")
        
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(imgSrc)
        
        photo.caption = src.fragments.fetchGirls.text
        
        images.append(photo)
        
        let browser = SKPhotoBrowser(originImage: holderImage ?? UIImage(), photos: images, animatedFromView: from)
        
        browser.initializePageIndex(0)
        
        view.present(browser, animated: true, completion: nil)
    }
    
    public static func getURLScheme(url: String) -> String {
        if url.contains("zhihu.com") {
            let seqs = url.split(separator: "/")
            let id = seqs[seqs.count - 1]
            print(id)
            return "zhihu://answers/\(id)"
        }
        
        if url.contains("jike.com") {
            // example: https://web.okjike.com/topic/58b6480a2275da0014628065/official
            
            let regex = ""
            
            return "jike://page.jk/message/5c0d03d9845e060093648a46"
        }
        
        return url
    }
}

struct AthenaColors {
    static let green = UIColor.init(red: 0.80, green: 0.86, blue: 0.22, alpha: 1)
    static let blue = UIColor.init(red:0.00, green:0.74, blue:0.83, alpha:1.0)
}

