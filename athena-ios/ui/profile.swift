//
//  profile.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/24.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var logged = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination: AuthView(), isActive: $logged) {
                Text("go")
            }
        }
    }
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
