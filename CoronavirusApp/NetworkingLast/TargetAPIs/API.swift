//
//  MoviesAPI.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import Moya

extension RestAPI: TargetType {
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return nil
    }

    public var baseURL: URL {
        guard let url = URL(string: RouterBase.clientApiURL()) else {
            return URL(fileURLWithPath: "")
        }
        return url
    }

    public var path: String {
        switch self {
        case .getGlobalFigures:
            return RouterURLs.figures()
        case .getFiguresByCountry:
            return RouterURLs.figuresByCountry()
        }
    }

    public var task: Task {
        switch self {
        case .getGlobalFigures, .getFiguresByCountry:
            let result = Task.requestPlain
            return result
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getGlobalFigures, .getFiguresByCountry:
            return .get
        }
    }
}
