//
//  Mappable.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

public protocol Mappable: Decodable {
    init?(jsonString: String)
    static func dateFormat() -> DateFormatter
}

public extension Mappable {
    
    private static var customDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.dateFormat())
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    init?(jsonString: String)  {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            self = try Self.customDecoder.decode(Self.self, from: data)
        } catch let DecodingError.valueNotFound(type, context) {
            debugPrint("[T] Mappable Error valueNotFound - type: \(type) context: \(context)")
            return nil
        } catch let DecodingError.keyNotFound(key, context) {
            debugPrint("[T] Mappable Error keyNotFound - key: \(key) context: \(context)")
            return nil
        } catch let DecodingError.typeMismatch(type, context) {
            debugPrint("[T] Mappable Error typeMismatch - type: \(type) context: \(context)")
            return nil
        } catch let DecodingError.dataCorrupted(context) {
            debugPrint("[T] Mappable Error dataCorrupted - context: \(context)")
            return nil
        } catch {
            debugPrint("[T] Mappable Default Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func dateFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }
}

extension Array: Mappable where Element: Mappable { }
