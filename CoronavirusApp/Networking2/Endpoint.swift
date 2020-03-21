//
//  Endpoint.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

struct Endpoint {
    var path: String
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parameters: [String: Any]?
}
