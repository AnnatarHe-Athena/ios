//
//  profile.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/24.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI
import QGrid

struct ProfileView: View {
    
    @State private var notLogged = true
    
    @EnvironmentObject private var profileData: ProfileStore
    
    var body: some View {
        VStack(alignment: .center) {
            Group {
                UserCard(profile: profileData.profile)
                Divider()
                
                QGrid(profileData.collections, columns: 3) { c in
                    NavigationLink(destination: DetailView(cell: c)) {
                        WebImage(url: URL(string: c.img))
                    }
                    .navigationBarTitle("Detail")
                }
            }.sheet(isPresented: $notLogged) {
                AuthView().environmentObject(self.profileData)
            }.onAppear(perform: {
                self.$notLogged.wrappedValue = self.profileData.profile.isFake
            })
            
        }
    }
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
