//
//  skipModal.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/30.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct SkipModal: View {
    
    let listStore: ListStore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var inputLastId = ""
    
    var body: some View {
        VStack {
            TextField("last item id", text: self.$inputLastId)
                .keyboardType(.numberPad)
                .padding()
            
            Button(action: {
                self.listStore.JustSkip(id: "111")
                self.listStore.LoadMore()
                self.presentationMode.wrappedValue.dismiss()
                print(self.presentationMode, self.listStore)
            }, label: {
                Text("confirm")
            })
        }
    }
}

struct skipModal_Previews: PreviewProvider {
    static var previews: some View {
        SkipModal(listStore: ListStore())
    }
}
