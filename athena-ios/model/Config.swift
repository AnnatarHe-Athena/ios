//
//  Config.swift
//  athena-ios
//
//  Created by AnnatarHe on 20/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

let devServer = "http://localhost:9000/graphql/v1"

let prodServer = "https://api.dbg.annatarhe.com/graphql/v1"

import Apollo

class Config {
    
    static var token: String = ""
    
    static func getApolloClient() -> ApolloClient {
        
        let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["athena-token": Config.token]
        var url: URL
        
        #if DEBUG
            url = URL(string: devServer)!
        #else
            url = URL(string: prodServer)!
        #endif
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }
}
