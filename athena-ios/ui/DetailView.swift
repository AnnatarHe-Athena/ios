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
    @State var isAlertVisible = false
    @State var alertText = ""
    
    var body: some View {
        VStack {
            Text(cell.content).font(.largeTitle)
            
            Text(cell.text).font(.caption).foregroundColor(.gray)
            
            Divider()
            
            WebImage(url: URL(string: cell.img))
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .center)
            
            HStack {
                Text("来源").font(.caption)
                
                Button(action: onFormIdClick) {
                    Text(cell.fromID)
                }
            }.padding()
            
            HStack {
                Text("链接").font(.caption)
                
                Button(action: onFromUrlClick) {
                    Text(cell.fromURL)
                }
            }
        }.alert(isPresented: $isAlertVisible, content: {
            Alert(title: Text("⚠️"), message: Text($alertText.wrappedValue))
        })
    }
    
    
    func onFormIdClick() {
        let isWeibo = cell.fromURL.contains("https://weibo.com")
        let isJike = cell.fromURL.contains("https://web.okjike.com")
        guard isWeibo || isJike else {
            self.isAlertVisible.toggle()
            self.alertText = "not support yet"
            return
        }
        var url: URL = URL(string: "https://db.annatarhe.com")!
        
        if isWeibo {
            let urlScheme = "sinaweibo://userinfo?uid=\(cell.fromID)"
            url = URL(string: urlScheme)!
        }
        
        if isJike {
            let userURL = URL(string: cell.fromID)
            let paths = userURL?.path.split(separator: "/")
            let userID = String(paths![paths!.count - 1])
            url = URL(string: "jike://page.jk/user/\(userID)")!
        }
        
        if !UIApplication.shared.canOpenURL(url) {
            self.isAlertVisible.toggle()
            self.alertText = "not support yet"
            return
        }
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
    func onFromUrlClick() {
        let fromUrl = cell.fromURL
        
        let urlScheme = Utils.getURLScheme(url: fromUrl)
        var url = URL(string: urlScheme)
        if !UIApplication.shared.canOpenURL(URL(string: urlScheme)!) {
            url = URL(string: fromUrl)
        }
        
        UIApplication.shared.open(url!, completionHandler: nil)
    }
}

struct detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(cell: CellItem(
            id: "1111", img: "https://picsum.photos/200/300?random=1", permission: 2, text: "hello world", content: "test data", fromID: "", fromURL: ""
        ))
    }
}
