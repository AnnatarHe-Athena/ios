//
//  SkipButton.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/30.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct SkipButton: View {
    
    @State var alertPresented = false
    
    @EnvironmentObject private var listStore: ListStore
    
    var body: some View {
        NavigationLink(destination: SkipModal(listStore: self.listStore)) {
            Text("➡️")
        }.navigationBarTitle("Skip")
    }
    
    
}

struct SkipButton_Previews: PreviewProvider {
    static var previews: some View {
        SkipButton()
    }
}
