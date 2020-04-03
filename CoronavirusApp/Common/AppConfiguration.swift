//
//  AppConfiguration.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class AppConfiguration: NSObject {
    
    private override init() { }
    @objc static let shared: AppConfiguration = AppConfiguration()
    
    @objc lazy var currentLanguageTableName: String = {
        return self.getCurrentLanguageTableName()
    }()
    
    internal func getCurrentLanguageTableName() -> String {
        return localizableError
    }
}
