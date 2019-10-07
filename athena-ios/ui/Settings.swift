//
//  Settings.swift
//  athena-ios
//
//  Created by annatar.he on 2019/10/7.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @State var settingsFollowLastRow = false;
    
    var body: some View {
        
        VStack {
            HStack {
                Toggle(isOn: self.$settingsFollowLastRow, label: {
                    Text("⛔️ 是否跟随最后一条记录")
                })
            }.padding()
            Button(action: {
                // TODO: logout
                // 1. clear config uid
                // 2. remove all the data
                // 3. redirect to login page
            }, label: {
                Text("Logout")
            })
        }
        .onAppear(perform: {
            // FIXME:
            let v = preference<Bool>(key: "setting:followLastRow", value: false)
            self.settingsFollowLastRow = v
        })
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
