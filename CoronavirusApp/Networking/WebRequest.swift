//
//  WebRequest.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestFailure = (NSError) -> Void
typealias RequestSucceeded<T: Codable> = (T?) -> Void

protocol WebRequestProtocol {
    func request<T>(endpoint: Endpoint,
                    success: @escaping RequestSucceeded<T>,
                    failure: @escaping RequestFailure)
}

class WebRequest: WebRequestProtocol {
     func request<T>(endpoint: Endpoint,
                     success: @escaping RequestSucceeded<T>,
                     failure: @escaping RequestFailure) where T: Codable {
        let request = AF.request(endpoint.path,
                                 method: endpoint.method,
                                 parameters: endpoint.parameters,
                                 encoding: endpoint.encoding,
                                 headers: nil,
                                 interceptor: nil)
        request.validate().responseJSON { (response) in
            let result = response.result
            switch result {
            case .success(let response):
                let jsonString = response as? [String: Any]
                let data = jsonString?.description.data(using: .utf8)
                let responseData = try? JSONDecoder().decode(T.self, from: data!)
                success(responseData)
            case .failure(let error):
                failure(NSError(domain: error.errorDescription ?? "", code: 1, userInfo: nil))
            }
        }
    }
    
}
