//
//  FiguresInTheWorldViewModel.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class FiguresInTheWorldViewModel {
    var coronavirusWorldFigures = [FiguresByCountry]()
    
    func getFiguresByCountry(completion: @escaping () -> Void) {
         SAFiguresByCountryServiceResult.shared.getFiguresByCountry(success: { [weak self] (response) in
            self?.coronavirusWorldFigures = response.data
            completion()
             print(response)
         }) { (error) in
            completion()
             print(error)
         }
     }
    
    func getGlobalFigures(completion: @escaping (GlobalStats?) -> Void) {
        SAGlobalFiguresServiceResult.shared.getGlobalFigures(success: { [weak self] (response) in
            print(response)
            completion(response)
            //self?.getFiguresByCountry()
        }) { (error) in
            print(error)
        }
    }
}
