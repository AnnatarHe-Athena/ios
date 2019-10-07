//
//  listStore.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/30.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation

class ListStore: ObservableObject {
    @Published private(set) var list: [CellItem] = []
    @Published private(set) var lastId: String = String(1 << 30)
    @Published private(set) var category: String = ""
    @Published private(set) var loading = false
    @Published private(set) var hasMore = true
    @Published private(set) var errors: (Error) = nil
    
    private let STEP = 10
    
    func UpdateCategory(cate: String) {
        self.category = cate
        self.list.removeAll()
    }
    
    func JustSkip(id: String) {
        self.lastId = id
    }
    
    private func fakeLoad() {
        for i in 1...10 {
            self.list.append(CellItem(
                id: String(i), img: "https://picsum.photos/200/200?random=\(i)", permission: 2, text: "", content: "lorem \(i)", fromID: String(i), fromURL: String(i)
            ))
        }
    }
    
    func LoadMore() {
        
        fakeLoad()
        return
        
        guard !self.loading else {
            return
        }
        
        self.loading.toggle()
        
        Config.getApolloClient().fetch(
            query: FetchGirlsQueryQuery(from: Int(self.category)!, take: self.STEP, hideOnly: false, last: self.lastId)
        ) { result in
            
            switch result {
            case .success(let resultData):
                let dataItems = (resultData.data?.girls)!
                if dataItems.count == 0 {
                    self.hasMore = false
                } else {
                    self.lastId = (dataItems.last??.fragments.fetchGirls.id)!
                }
                dataItems.forEach({ cell in
                    self.list.append(
                        CellItem(
                            id: (cell?.fragments.fetchGirls.id)!,
                            img: (cell?.fragments.fetchGirls.img)!,
                            permission: (cell?.fragments.fetchGirls.permission)!,
                            text: (cell?.fragments.fetchGirls.text)!,
                            content: (cell?.fragments.fetchGirls.content)!,
                            fromID: (cell?.fragments.fetchGirls.fromId)!,
                            fromURL: (cell?.fragments.fetchGirls.fromUrl)!
                        )
                    )
                })
                
                self.loading.toggle()
            case .failure(let err):
                print(err)
                self.errors = err
            }
        }
    }
    
}
