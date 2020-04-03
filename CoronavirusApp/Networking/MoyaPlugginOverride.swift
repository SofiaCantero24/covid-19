//
//  File.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Moya
import Result
import SwiftyJSON
import Foundation

public struct CustomAccessTokenPlugin: PluginType {
    public static let requestLog = "Request: "
    public static let methodLog = "HTTP Request Method: "
    public static let bodyLog = "Request Body: "
    
    
    func logNetworkRequest(_ request: URLRequest?) -> String {
        
        var output = [String]()
        output.append(CustomAccessTokenPlugin.requestLog + (request?.description ?? ""))
        
        if let httpMethod = request?.httpMethod {
            output.append(CustomAccessTokenPlugin.methodLog + httpMethod)
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output.append(CustomAccessTokenPlugin.bodyLog + stringOutput)
        }
        
        let string = output.joined(separator: "\n")
        return string
    }
    
}

protocol NetworkErrorPluginDelegate: class {
    func returnError(status: Int, code: String)
    func targetCalled(target: TargetType)
}

public final class NetworkErrorPlugin: PluginType {
    
    weak var delegate: NetworkErrorPluginDelegate?
    init(delegate: NetworkErrorPluginDelegate) {
        self.delegate = delegate
    }
    public func willSend(_ request: RequestType, target: TargetType) {
        print (request)
        delegate?.targetCalled(target: target)
    }
    /// Called by the provider as soon as a response arrives, even if the request is canceled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        //        print (target)
        switch result {
        case let .success(result):
            if result.statusCode > 300 {
                do {
                    let json = try JSON(data: result.data)
                    delegate?.returnError(status: result.statusCode, code: json["errorCodeKey"].stringValue)
                } catch {
                    delegate?.returnError(status: result.statusCode, code: "")
                }
            }
        case .failure(let error):
            var desc = ""
            if let edesc = error.errorDescription {
                desc = edesc
            }
            delegate?.returnError(status: -1, code: desc)
        }
        
    }
    
}
