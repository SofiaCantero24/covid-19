//
//  Networking.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func request(method: HTTPMethod,
                 parameters: [String: Any]?,
                 encoding: ParameterEncoding,
                 completion: @escaping (_ response: Any?, _ error: Error?) -> ())
}

class Networking: NetworkingProtocol {
    var webRequest: WebRequestProtocol

    init(webRequest: WebRequestProtocol = WebRequest()) {
        self.webRequest = webRequest
    }

    func request(method: HTTPMethod,
                 parameters: [String: Any]?,
                 encoding: ParameterEncoding,
                 completion: @escaping (_ response: Any?, _ error: Error?) -> ()) {
        webRequest.request(toUrl: "",
                           method: method,
                           parameters: parameters,
                           encoding: encoding,
                           headers: nil,
                           completion: completion)
    }
}
