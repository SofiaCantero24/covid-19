//
//  GlobalStats.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

struct GlobalStats: Mappable {
    var stats: GlobalFigures?
}

struct GlobalFigures: Mappable {
    var confirmed: String?
    var deaths: String?
    var recovered: String?
    var active: String?
}

