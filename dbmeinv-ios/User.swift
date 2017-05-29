//
//  User.swift
//  dbmeinv-ios
//
//  Created by AnnatarHe on 29/05/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserProfile {
    let id:Int
    var username: String
    var avatarUrl: String = "http://placehold.it/50x50"
    var collections: [Plato?] = []
}

class User {
    
    var user: UserProfile?
    
    static func auth(email:String, pwd: String) {
        let authUrl = URL.init(string: "\(Config.apiServer)/auth")
        Alamofire.request(authUrl!, method: .post).responseJSON { response in
            let json = JSON(data: response.result.value as! Data)
            
        }
    }
}
