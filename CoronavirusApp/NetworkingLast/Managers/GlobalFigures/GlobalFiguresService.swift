//
//  CityService.swift
//  PointPlayer
//
//  Created by Junior Sancho on 7/14/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class SAGlobalFiguresServiceResult {
    
    static let shared: SAGlobalFiguresServiceResult = SAGlobalFiguresServiceResult()
    
    func getGlobalFigures(success:@escaping (GlobalStats) -> Void,
                          failure:@escaping (Error) -> Void) {
        
        Network.request(target: .getGlobalFigures,
                        success: { (servicesResponse) in
                            if let result = GlobalStats(jsonString: servicesResponse.description){
                                success(result)
                            }else{
                                print("Error Parseo")
                            }
                            
        }, failure: { error in
            failure(error)
        })
    }
}

