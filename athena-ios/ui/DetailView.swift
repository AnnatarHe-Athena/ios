//
//  detail.swift
//  athena-ios
//
//  Created by annatar.he on 2019/10/1.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let cell: CellItem
    
    var body: some View {
        VStack {
            Text(cell.content).font(.largeTitle)
            
            Text(cell.text).font(.caption).foregroundColor(.gray)
            
            Divider()
            
            WebImage(url: URL(string: cell.img))
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .center)
            
            HStack {
                Text("来源").font(.caption)
                
                Button(action: {
                    
                }) {
                    Text(cell.fromID)
                }
            }.padding()
            
            HStack {
                Text("链接").font(.caption)
                
                Button(action: {
                    
                }) {
                    Text(cell.fromURL)
                }
            }
        }
    }
}

struct detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(cell: CellItem(
            id: "1111", img: "https://picsum.photos/200/300?random=1", permission: 2, text: "hello world", content: "test data", fromID: "", fromURL: ""
        ))
    }
}
