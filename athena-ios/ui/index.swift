//
//  index.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct IndexView: View {
    
    @State private var selection = 0
    @EnvironmentObject private var profileData: ProfileStore
    
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                CellsView().tabItem {
                    Image.init("home")
                    Text("list")
                }.tag(0)
                ProfileView().tabItem {
                    Image.init("user")
                    Text("Me")
                }.tag(1)
            }.navigationBarTitle(
                selection == 0 ? "Lists" : self.profileData.profile?.name ?? "Profile"
            )
        }
        
    }
}

struct index_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
