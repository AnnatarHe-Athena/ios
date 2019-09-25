//
//  profile.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/24.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var notLogged = true
    
    @EnvironmentObject private var profileData: ProfileStore
    
    
    var body: some View {
        VStack(alignment: .center) {
            Group {
                UserCard(profile: profileData.profile)
                Divider()
                Spacer()
            }.sheet(isPresented: $notLogged) {
                AuthView()
            }.onAppear(perform: {
                if (self.profileData.profile.isFake) {
                    self.$notLogged.wrappedValue = true
                }
            })
        }
    }
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
