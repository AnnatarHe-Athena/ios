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
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                CellsView().tabItem {
                    Image("home")
                    Text("list")
                }.tag(0)
                    .navigationBarTitle("lalallala")
                ProfileView().tabItem {
                    Image.init("user")
                    Text("Me")
                }.tag(1)
            }
            .shadow(radius: 10)
            .navigationBarTitle(
                selection == 0 ? "Lists" : "Profile"
            )
                .edgesIgnoringSafeArea(.top)
                .navigationBarItems(
                    leading: SkipButton(), trailing: CategoriesButton())
        }
        .environmentObject(ProfileStore())
        .environmentObject(ListStore())
    }
}

struct index_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
