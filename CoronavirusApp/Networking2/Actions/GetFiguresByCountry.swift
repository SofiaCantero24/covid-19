//
//  GetFiguresByCountry.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Alamofire

class GetFiguresByCountry {
    var networking: WebRequestProtocol

    init(networking: WebRequestProtocol = WebRequest()) {
        self.networking = networking
    }

    func execute(success: @escaping RequestSucceeded<CoronavirusCountries>,
                 failure: @escaping RequestFailure) {
        let endpoint = Endpoint(path: "",
                                method: .get,
                                encoding: URLEncoding.default,
                                parameters: nil)
        networking.request(endpoint: endpoint,
                           success: success,
                           failure: failure)
    }
}
