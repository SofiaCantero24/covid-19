//
//  Int+Extension.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/30/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
    var isSingular: Bool {
        return self == 1
    }
}
