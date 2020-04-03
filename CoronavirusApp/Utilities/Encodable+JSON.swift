//
//  Encodable+JSON.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

public extension Encodable {
    func json() -> [String: Any]? {
        do {
            let encodedData = try JSONEncoder().encode(self)
            if let dictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any] {
                return dictionary
            }
        } catch {}
        return nil
    }
}

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
