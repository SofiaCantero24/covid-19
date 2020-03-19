//
//  GetGlobalFigures.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

class GetGlobalFigures {
    var networking: NetworkingProtocol

    init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }

    func execute(completion: @escaping (_ response: Any?, _ error: Error?) -> ()) {
        networking.request(method: .get,
                           parameters: nil,
                           encoding: URLEncoding.default,
                           completion: completion)
    }
}
