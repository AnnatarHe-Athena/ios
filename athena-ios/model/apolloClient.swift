//
//  apolloClient.swift
//  athena-ios
//
//  Created by annatar.he on 2019/11/6.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation
import Apollo

class Apollo {
    static let shared = Apollo()
    
    private(set) lazy var client = ApolloClient(url: URL(string: "http://localhost:8080/graphql")!)
}

