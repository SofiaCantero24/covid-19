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
    var filteredFigures = [FiguresByCountry]()
    var searchActive = false
    
    var currentFiguresList: [FiguresByCountry] {
        return searchActive ? filteredFigures : coronavirusWorldFigures
    }
    
    var globalStats: GlobalStats? {
        return SAGlobalFiguresServiceResult.shared.globalStatsResponse
    }
    
    //MARK: - Public Methods
    func getFiguresByCountry(completion: @escaping () -> Void) {
         SAFiguresByCountryServiceResult.shared.getFiguresByCountry(success: { [weak self] (response) in
            self?.coronavirusWorldFigures = response.data
            self?.orderBy(tabType: .confirmed)
            completion()
         }) { (error) in
            completion()
         }
     }
    
    func orderBy(tabType: TabType) {
        coronavirusWorldFigures.sort { (last, current) -> Bool in
            switch tabType {
            case .confirmed:
                return last.confirmed ?? 0 > current.confirmed ?? 0
            case .deaths:
                return last.deaths ?? 0 > current.deaths ?? 0
            case .recoveries:
                return last.recovered ?? 0 > current.recovered ?? 0
            }
        }
    }
    
    func filterFigures(byString string: String) {
        guard !string.isEmpty else {
            filteredFigures = coronavirusWorldFigures
            return
        }
        filteredFigures = coronavirusWorldFigures.filter({ figures -> Bool in
            return (figures.countryRegion?.lowercased().contains(string.lowercased()) ?? false)
        })
    }
}
