//
//  Config.swift
//  athena-ios
//
//  Created by AnnatarHe on 20/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

let devServer = "http://localhost:9009/graphql/v1"

let prodServer = "https://api.dbg.annatarhe.com/graphql/v1"

import Apollo

class Config {
    
    static var token: String = ""
    
    static var userId: String = ""
    
    static func getApolloClient() -> ApolloClient {
        
        let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["athena-token": Config.token]

        #if DEBUG
            let url = URL(string: devServer)!
        #else
            let url = URL(string: prodServer)!
        #endif
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }
}
