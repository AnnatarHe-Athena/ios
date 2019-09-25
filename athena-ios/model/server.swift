//
//  server.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation


struct CellItem {
    let id: String
    let img: String
    let permission: Int
    let text: String
    let content: String
    let fromID: String
    let fromURL: String
}


enum UserRole {
    case Tourist;
    case Normal;
    case Plus;
    case Manager;
    case Founder;
    
}

fileprivate func getUserRole(roleNum: Int) -> UserRole {
    if roleNum < 20 {
        return .Tourist
    } else if roleNum < 91 {
        return .Normal
    } else if roleNum < 140 {
        return .Plus
    } else if roleNum < 190 {
        return .Manager
    } else {
        return .Founder
    }
}

class ProfileData {
    public let id: Int
    public let email: String
    public let name: String
    public let pwd: String
    public let avatar: URL
    public let bio: String
    public let role: UserRole
    
    init(profile: FetchProfileWithCollectionsQuery.Data.User.Fragments) {
        
        let p = profile.profile
        
        self.id = Int((p.id)!)!
        self.email = p.email!
        self.name = p.name!
        self.pwd = ""
        
        var avatarUrl: String
        
        
        
        if p.avatar == "null" {
            avatarUrl = "https://via.placeholder.com/300x300"
        } else {
            avatarUrl = (p.avatar)!
        }
        self.avatar = URL(string: avatarUrl)!
        self.bio = p.bio!
        self.role = getUserRole(roleNum: p.role!)
        
    }
}
