//
//  RouterBase.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

public struct RouterBase {
    static let https = "https://"
    
    public static func clientApiURL() -> String {
        return "\(https)\(URLConstants.hostName)"
    }
    
    public static func v1(withPath path: String) -> String {
        return "\((URLConstants.apiVersion))/\(path)"
    }
}
