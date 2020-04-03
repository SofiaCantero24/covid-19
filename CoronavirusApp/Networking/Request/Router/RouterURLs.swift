//
//  RouterURLs.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

public struct RouterURLs {
    public static func figures() -> String {
        return RouterBase.v1(withPath: "\(URLConstants.pathVersion)/\(URLConstants.figures)")
    }
    public static func figuresByCountry() -> String {
        return RouterBase.v1(withPath: "\(URLConstants.pathVersion)/\(URLConstants.figuresByCountry)")
    }
}
