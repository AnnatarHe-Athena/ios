//
//  OpenData.swift
//  athena-ios
//
//  Created by annatar.he on 2019/10/7.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

struct OpenData: View {
    var body: some View {
        VStack {
            HStack {
                Text("已有")
                Text("22222")
                Text("条数据")
            }
            
            HStack {
                Text("已有")
                Text("22222122")
                Text("个用户")
            }
        }
    }
}

struct OpenData_Previews: PreviewProvider {
    static var previews: some View {
        OpenData()
    }
}
