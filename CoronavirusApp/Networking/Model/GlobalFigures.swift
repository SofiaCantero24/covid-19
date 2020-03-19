//
//  GlobalStats.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

struct GlobalStats: Codable {
    var stats: GlobalFigures
}

struct GlobalFigures: Codable {
    var confirmed: Int
    var deaths: Int
    var recoveries: Int
}

