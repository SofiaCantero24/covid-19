//
//  Network.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

class Network {
    
    static var provider = MoyaProvider<RestAPI>(plugins: [CustomAccessTokenPlugin(),
                                                          NetworkLoggerPlugin(verbose: true,
                                                                              responseDataFormatter:JSONResponseDataFormatter)])
    static var tokenWasUpdated = false
    
    static func request(
        target: RestAPI,
        isRetry: Bool = false,
        success successCallback: @escaping (JSON) -> Void,
        failure failureCallback: @escaping (NSError) -> Void
        ) {
        
        let _ = buildRequest(target: target, isRetry: isRetry, success: successCallback, failure:failureCallback)
    }
    enum StatusCode {
        static let ok = 200
        static let badRequest = 400
        static let unauthorized = 401
        static let forbidden = 403
        static let notFound = 404
        static let serviceUnavailable = 503
        static let cancelled = -999
    }
    
    
    static func buildRequest(
        target: RestAPI,
        isRetry: Bool = false,
        success successCallback: @escaping (JSON) -> Void,
        failure failureCallback: @escaping (NSError) -> Void
        ) -> Cancellable {
        
        return
            provider.request(target) { result in
                print(result)
                switch result {
                case let .success(result):
                    print(result.data)
                    
                    if result.statusCode == StatusCode.ok {
                        do {
                            let json = try JSON(data: result.data)
                            successCallback(json)
                        } catch {
                            successCallback(JSON.null)
                            return
                        }
                    } else if result.statusCode != StatusCode.forbidden && isRetry {
                        self.request(target: target, isRetry: true, success: successCallback, failure: failureCallback)
                    }else{
                        handleGeneralError(failureBlock: failureCallback)
                        
                    }
                case .failure(let error)://network error
                    if case .underlying(let swiftError, _) = error {
                        let nsError = swiftError as NSError
                        if nsError.code == StatusCode.cancelled {
                            handleCancelledRequestError(failureBlock: failureCallback)
                        } else {
                            handleNetworkError(failureBlock: failureCallback)
                        }
                    } else {
                        handleNetworkError(failureBlock: failureCallback)
                    }
                }
        }
    }
}
