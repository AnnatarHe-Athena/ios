//
//  auth.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    
    @State var email = "";
    @State var pwd = "";
    
    var body: some View {
        Form {
            TextField("Username", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("password", text: $pwd)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                print("did tap")
            }, label: {
                Text("Submit")
            })
            .padding()
            .cornerRadius(4)
            
            Button(action: {
                print("did tap")
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
