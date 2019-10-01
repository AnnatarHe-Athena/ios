//
//  AthenaError.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/30.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation

class AthenaError: Error {
    let msg: String
    
    init(m: String) {
        msg = m
    }
}
