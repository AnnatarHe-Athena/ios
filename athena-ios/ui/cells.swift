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
    private let a = "https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=8816325c4036acaf4ded9eae1db0e675/fcfaaf51f3deb48fcfadd0bbfb1f3a292cf5788a.jpg"
    var body: some View {
        List {
            Group {
                Image(uiImage: UIImageView().sd_setImage(with: URL(string: a)!, completed: nil))
            }
        }
    }
}

struct cells_Previews: PreviewProvider {
    static var previews: some View {
        CellsView()
    }
}
