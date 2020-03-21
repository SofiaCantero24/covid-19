//
//  CollectionsService.swift
//  TorreTest
//
//  Created by Junior Sancho on 8/29/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class SAFiguresByCountryServiceResult {
    
    static let shared: SAFiguresByCountryServiceResult = SAFiguresByCountryServiceResult()
    
    func getFiguresByCountry(success:@escaping (CoronavirusCountries) -> Void,
                          failure:@escaping (Error) -> Void) {
        
        Network.request(target: .getFiguresByCountry,
                        success: { (servicesResponse) in
                            if let result = CoronavirusCountries(jsonString: servicesResponse.description){
                                success(result)
                            }else{
                                print("Error Parseo")
                            }
                            
        }, failure: { error in
            failure(error)
        })
    }
}
