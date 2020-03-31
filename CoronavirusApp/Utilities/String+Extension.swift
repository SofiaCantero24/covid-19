//
//  String+Extension.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/30/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

extension String {
    var stringWithoutGroupingSeparator: String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    
    var localizable: String {
        let regionCode = Locale.preferredLanguages.first
        var tableName = "English"
        if regionCode?.contains("es") == true {
            tableName = "Spanish"
        }
        return NSLocalizedString(self, tableName: tableName, value: "self", comment: "")
    }
}
