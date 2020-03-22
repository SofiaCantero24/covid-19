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
    
    func getFiguresByCountry(completion: @escaping () -> Void) {
         SAFiguresByCountryServiceResult.shared.getFiguresByCountry(success: { [weak self] (response) in
            self?.formatFigures(worldFigures: response.data)
            self?.orderBy(tabType: .confirmed)
            completion()
         }) { (error) in
            completion()
         }
     }
    
    func getGlobalFigures(completion: @escaping (GlobalStats?) -> Void) {
        SAGlobalFiguresServiceResult.shared.getGlobalFigures(success: { [weak self] (response) in
            completion(response)
        }) { (error) in
            
        }
    }
    
    func formatFigures(worldFigures: [FiguresByCountry]) {
        coronavirusWorldFigures = worldFigures.map({ countryFigure in
            guard let confirmed = Int(countryFigure.confirmed),
                let death = Int(countryFigure.deaths),
                let recovered = Int(countryFigure.recovered) else { return countryFigure }
            return FiguresByCountry(idApi: countryFigure.idApi,
                                    countryRegion: countryFigure.countryRegion,
                                    lat: countryFigure.lat,
                                    long: countryFigure.long,
                                    confirmed: confirmed.formattedWithSeparator,
                                    deaths: death.formattedWithSeparator,
                                    recovered: recovered.formattedWithSeparator)
        })
    }
    
    func orderBy(tabType: TabType) {
        coronavirusWorldFigures.sort { (last, current) -> Bool in
            guard let lastConfirmed = Int(last.confirmed.stringWithoutGroupingSeparator),
                let currentConfirmed = Int(current.confirmed.stringWithoutGroupingSeparator),
                let lastDeaths = Int(last.deaths.stringWithoutGroupingSeparator),
                let currentDeaths = Int(current.deaths.stringWithoutGroupingSeparator),
                let lastRecovered = Int(last.recovered.stringWithoutGroupingSeparator),
                let currentRecovered = Int(current.recovered.stringWithoutGroupingSeparator) else {
                    return false
            }
            switch tabType {
            case .confirmed:
                return lastConfirmed > currentConfirmed
            case .deaths:
                return lastDeaths > currentDeaths
            case .recoveries:
                return lastRecovered > currentRecovered
            }
        }
    }
    
    func filterFigures(byString string: String) {
        guard !string.isEmpty else {
            filteredFigures = coronavirusWorldFigures
            return
        }
        filteredFigures = coronavirusWorldFigures.filter({ figures -> Bool in
            return figures.countryRegion.lowercased().contains(string.lowercased())
        })
    }
}
