//
//  MapViewModel.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/21/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

struct CountryLocation {
    let lat: Double
    let long: Double
    let markerSize: CGFloat
    let countryName: String
    let confirmedCases: String
}

class MapViewModel {
    func getCountryLocationArray(completion: @escaping ([CountryLocation]?) -> Void) {
        SAFiguresByCountryServiceResult.shared.getFiguresByCountry(success: { [weak self] (response) in
            let countryLocations = self?.createCountryLocationArray(from: response.data)
            completion(countryLocations)
        }) { (error) in
           completion(nil)
        }
    }
    
    private func createCountryLocationArray(from array: [FiguresByCountry]) -> [CountryLocation] {
        let greatestValue = greatestConfirmedValue(fromFigures: array)
        return array.map { figure in
            let size = calculateMarkerSize(withValue: figure.confirmed, greatestValue: greatestValue)
            guard let lat = Double(figure.lat),
                let long = Double(figure.long),
                let confirmedCases = Int(figure.confirmed) else {
                return CountryLocation(lat: 0,
                                       long: 0,
                                       markerSize: size,
                                       countryName: figure.countryRegion,
                                       confirmedCases: "Hay \(figure.confirmed) casos confirmados")
            }
            let confirmedCasesDescription = confirmedCases.isSingular ? Localizables.confirmedDescriptionSingular
                : String(format: Localizables.confirmedDescriptionPlural, confirmedCases.formattedWithSeparator)
            return CountryLocation(lat: lat,
                                   long: long,
                                   markerSize: size,
                                   countryName: figure.countryRegion,
                                   confirmedCases: confirmedCasesDescription)
        }
    }
    
    private func greatestConfirmedValue(fromFigures figures: [FiguresByCountry]) -> Int {
        let greatestConfirmedFigure = figures.max { last, current in
            let lastConfirmed = Int(last.confirmed) ?? 0
            let currentConfirmed = Int(current.confirmed) ?? 0
            return lastConfirmed < currentConfirmed
        }
        return Int(greatestConfirmedFigure?.confirmed ?? "") ?? 0
    }
    
    private func calculateMarkerSize(withValue value: String, greatestValue: Int) -> CGFloat {
        let confirmedValue = Int(value) ?? 0
        let percentageSize = confirmedValue * 150 / greatestValue
        let finalSize = max(CGFloat(percentageSize), CGFloat(20))
        return min(CGFloat(finalSize), CGFloat(150))
    }
}
