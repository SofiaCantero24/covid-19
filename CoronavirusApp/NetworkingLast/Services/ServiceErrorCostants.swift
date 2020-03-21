//
//  ServiceErrorCostants.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

let localizableError = "LocalizableError"

let errorMinus999 = "ErrorCode_-999"
let error1000 = "ErrorCode_1000"
let requestCancelled = "RequestCancelled"
let error0503 = "ErrorCode_0503"
let errorCallingService = "ErrorCallingService"
let error0001 = "ErrorCode_0001"


func customLocalizedString(_ key: String) -> String {
    let currentLanguageTableName = AppConfiguration.shared.currentLanguageTableName
    return Bundle.main.localizedString(forKey: (key), value: "", table: currentLanguageTableName)
}
