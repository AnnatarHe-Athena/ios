//
//  Config.swift
//  athena-ios
//
//  Created by AnnatarHe on 20/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//
import Apollo


//let devServer = "http://localhost:9009/graphql/v1"
let devServer = "http://192.168.0.102:9009/graphql/v1"

let prodServer = "https://api.dbg.annatarhe.com/graphql/v1"

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
        var networkTransport = HTTPNetworkTransport(
            url: url,
            delegate: ApolloDelegate()
        )
        return ApolloClient(networkTransport: networkTransport)
    }
}

class ApolloDelegate: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return true
    }
    
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          willSend request: inout URLRequest) {
        
        // Get the existing headers, or create new ones if they're nil
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        
        // Add any new headers you need
        headers["athena-token"] = Config.token
        
        // Re-assign the updated headers to the request.
        request.allHTTPHeaderFields = headers
    }
}



extension Config: HTTPNetworkTransportTaskCompletedDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          didCompleteRawTaskForRequest request: URLRequest,
                          withData data: Data?,
                          response: URLResponse?,
                          error: Error?) {
        // logging
    }
}

// MARK: - Retry Delegate

extension Config: HTTPNetworkTransportRetryDelegate {
    
    func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          receivedError error: Error,
                          for request: URLRequest,
                          response: URLResponse?,
                          retryHandler: @escaping (_ shouldRetry: Bool) -> Void) {
        
    }
}
