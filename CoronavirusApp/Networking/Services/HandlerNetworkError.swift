//
//  HandlerNetworkError.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

func handleNetworkError(failureBlock:@escaping (NSError) -> Void) {
    let error = NSError().generateLocalizedError(errorDomain: error1000, code: 1000, messageKey: error1000)
    failureBlock(error)
}

func handleCancelledRequestError(failureBlock: @escaping (NSError) -> Void) {
    let error = NSError().generateLocalizedError(errorDomain: errorMinus999, code: Network.StatusCode.cancelled, messageKey: requestCancelled)
    failureBlock(error)
}

func handleError503(failureBlock: @escaping (NSError) -> Void) {
    let error = NSError().generateLocalizedError(errorDomain: error0503, code: 0503, messageKey: error0503)
    failureBlock(error)
}

func handleGeneralError(failureBlock:@escaping (NSError) -> Void) {
    let error = NSError().generateLocalizedError(errorDomain: errorCallingService, code: 0001, messageKey: error0001)
    failureBlock(error)
}


extension NSError {
    func generateLocalizedError(errorDomain: String, code: NSInteger, messageKey: String) -> NSError {
        let info = [
            NSLocalizedDescriptionKey: customLocalizedString(messageKey)
        ]
        return NSError(domain: errorDomain, code: code, userInfo: info)
    }
}
