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
import LocalAuthentication


class ProfileStore: ObservableObject {
    @Published private(set) var profile: ProfileData = ProfileData()
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
    
    func fingerCheck(onSuccess: @escaping () -> Void, onError: @escaping (_ err: Error) -> Void) {
        
        let context = LAContext()
        var err: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &err) else {
            print(err)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请指纹解锁", reply: { success, error in
            guard success == true else {
                print(error)
                return
            }
            if success {
                // dismiss and reload data
                
                let keychainSwift = KeychainSwift()
                guard let email = keychainSwift.get("email"), let pwd = keychainSwift.get("pwd") else {
                    onError(AthenaError(m: "failed to get email"))
                    return
                }
                
                DispatchQueue.main.async {
                    self.login(_email: email, _pwd: pwd, onSuccess: onSuccess, onError: onError)
                }
                return
                
            }
            
            if let error = error as NSError? {
                // 获取错误信息
                let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                print(message)
                onError(AthenaError(m: message))
            }
            
        })
        
    }
    
    
    
    private func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.biometryLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.biometryNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
}
