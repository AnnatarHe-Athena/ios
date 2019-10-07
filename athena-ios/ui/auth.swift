//
//  auth.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var profileData: ProfileStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var email = "";
    @State var pwd = "";
    
    func done() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            SecureField("password", text: $pwd)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                self.profileData.login(_email: self.email, _pwd: self.pwd, onSuccess: {
                    self.done()
                }, onError: { err in
                    print("error", err)
                })
            }, label: {
                Text("Submit")
            })
            .padding()
            .cornerRadius(4)
            
            Button(action: {
                self.profileData.fingerCheck(onSuccess: {
                    // TODO: dismiss
                    self.done()
                }, onError: { err in
                    print("error", err)
                    // TODO: dismiss
//                    self.done()
                })
            }, label: {
                Text("🤚 指纹登陆")
            })
            .padding()
            
        }.navigationBarTitle("username")
    }
    
    
    
}

struct auth_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
