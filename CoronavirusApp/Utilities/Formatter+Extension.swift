//
//  NumberFormater.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/21/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

