//
//  Config.swift
//  athena-ios
//
//  Created by AnnatarHe on 20/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import Apollo

class Config {
    static var token = ""
    
    static func getApolloClient() -> ApolloClient {
        
        let configuration = URLSessionConfiguration.default
            // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["athena-token": Config.token]
            
        let url = URL(string: "http://localhost:9000/graphql/v1")!
            
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }
}
