//
//  WebRequest.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

protocol WebRequestProtocol {
    func request(toUrl url: String,
                 method: HTTPMethod,
                 parameters: [String: Any]?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 completion: @escaping (_ response: Any?, _ error: Error?) -> ())
}

class WebRequest: WebRequestProtocol {
    func request(toUrl url: String,
                 method: HTTPMethod,
                 parameters: [String: Any]?,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders?,
                 completion: @escaping (_ response: Any?, _ error: Error?) -> ()) {
        let request = AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers,
                                 interceptor: nil)
        request.validate().responseJSON { (response) in
            let result = response.result
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
