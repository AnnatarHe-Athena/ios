//
//  user-card.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/25.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct UserCard: View {
    
    var profile: ProfileData
    
    var body: some View {
        HStack {
            WebImage(url: profile.avatar)
                .frame(width: 100, height: 100, alignment: .center)
                .offset(x: -30, y: 0)
            VStack {
                Text(profile.name)
                Text(profile.email)
            }
            .offset(x: 30, y: 0)
        }
        .frame(minWidth: 0, maxWidth: .infinity - 20, minHeight: 110, maxHeight: .infinity - 20, alignment: .center)
        .background(Color.secondary)
        .cornerRadius(8)
        .padding()
        .shadow(radius: 8)
        .onAppear(perform: {
            print("hello", self.profile)
        })
    }
}

struct user_card_Previews: PreviewProvider {
    static var previews: some View {
        UserCard(profile: ProfileData())
    }
}
