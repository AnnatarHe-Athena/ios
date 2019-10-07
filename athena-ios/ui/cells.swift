//
//  cells.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/24.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI
import UIKit

struct CellsView: View {
    
    @EnvironmentObject private var listStore: ListStore
    
    var body: some View {
        List {
//            GeometryProxy.frame() { g -> Text in
//                Text("loading")
//            }
            
            ForEach(self.listStore.list) { c in
                
                NavigationLink(
                    destination: DetailView(cell: c).navigationBarTitle(Text("内容"))
                ) {
                    Group {
                        WebImage(url: URL(string: c.img))
                            .frame(minWidth: CGFloat(0), maxWidth: .infinity, minHeight: CGFloat(0), maxHeight: CGFloat(500), alignment: .center)
                    }
                    }.isDetailLink(true)
                .labelsHidden()
            }
            
            if self.listStore.hasMore {
                Text("loading more").onAppear(perform: {
                    self.listStore.LoadMore()
                })
            }
            
        }
    }
}

struct cells_Previews: PreviewProvider {
    static var previews: some View {
        CellsView()
    }
}
