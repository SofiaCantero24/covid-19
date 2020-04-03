//
//  CityService.swift
//  PointPlayer
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class SAGlobalFiguresServiceResult {
    static let shared: SAGlobalFiguresServiceResult = SAGlobalFiguresServiceResult()
    var globalStatsResponse: GlobalStats?
    
    func getGlobalFigures(success:@escaping (GlobalStats) -> Void,
                          failure:@escaping (Error) -> Void) {
        Network.request(target: .getGlobalFigures,
                        success: { (servicesResponse) in
                            if let result = GlobalStats(jsonString: servicesResponse.description) {
                                self.globalStatsResponse = result
                                success(result)
                            } else{
                                print("Error Parseo")
                            }
        }, failure: { error in
            failure(error)
        })
    }
}

