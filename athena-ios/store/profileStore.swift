//
//  profile.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation
import KeychainSwift
import Sentry


class ProfileStore: ObservableObject {
    @Published private(set) var profile: ProfileData?;
    @Published private(set) var loading: Bool = false;
    @Published private(set) var collections: [CellItem] = [];
    
    private var collectionsOffset = 0;
    
    private let keychain = KeychainSwift()
    
    func login(_email: String, _pwd: String, onSuccess: @escaping () -> Void, onError: @escaping (_ err: Error) -> Void) {
        
        if self.loading {
            return
        }
        
        self.loading.toggle()
        
        Config.getApolloClient().fetch(query: AuthQuery.init(email: _email, password: _pwd)) { result in
            
            self.loading.toggle()
            switch result {
            case .success(let res):
                let authData = res.data?.auth
                let userID = (authData?.id)!
                
                Config.token = (authData?.token)!
                Config.userId = userID
                self.keychain.set(_email, forKey: "email")
                self.keychain.set(_pwd, forKey: "pwd")
                // setup sentry user
                let sentryUser = User(userId: userID)
                sentryUser.email = _email
                
                Client.shared?.user = sentryUser
                onSuccess()
            case .failure(let err):
                onError(err)
            }
            
        }
    }
    
    func getUser() {
        guard !self.loading else {
            return
        }
        
        self.loading.toggle()
        
        Config.getApolloClient().fetch(query: FetchProfileWithCollectionsQuery.init(id: Int(Config.userId)!, from: self.collectionsOffset, size: 20)) { result in
            self.loading.toggle()
            self.collectionsOffset += 20
            switch result {
            case .success(let resultData):
                
                self.profile = ProfileData(profile: (resultData.data?.users!.fragments)!)
                
                resultData.data?.collections.flatMap {
                    $0.forEach { c in
                        let cell = c?.fragments.fetchGirls
                        self.collections.append(
                            CellItem(
                                id:(cell?.id)!,
                                img: (cell?.img)!,
                                permission: (cell?.permission)!,
                                text: (cell?.text)!,
                                content: (cell?.content)!,
                                fromID: (cell?.fromId)!,
                                fromURL: (cell?.fromUrl)!
                            )
                        )
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
