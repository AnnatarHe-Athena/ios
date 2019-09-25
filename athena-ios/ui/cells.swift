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
    private var cells: [CellItem] = []
    
    init() {
        for n in 1...10 {
            cells.append(CellItem(
                id: String(n), img: "https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=8816325c4036acaf4ded9eae1db0e675/fcfaaf51f3deb48fcfadd0bbfb1f3a292cf5788a.jpg", permission: 2, text: "hello world", content: "hello world", fromID: "", fromURL: ""
            ))
        }
    }
    
    var body: some View {
        List(cells, id: \.id) { c in
            Group {
                WebImage(url: URL(string: c.img))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .center)
            }
        }
    }
}

struct cells_Previews: PreviewProvider {
    static var previews: some View {
        CellsView()
    }
}
