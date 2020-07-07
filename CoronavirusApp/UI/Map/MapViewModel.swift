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
            let size = calculateMarkerSize(withValue: figure.confirmed ?? 0, greatestValue: greatestValue)
            guard let lat = Double(figure.lat ?? ""),
                let long = Double(figure.long ?? ""),
                let confirmedCases = figure.confirmed else {
                return CountryLocation(lat: 0,
                                       long: 0,
                                       markerSize: size,
                                       countryName: figure.countryRegion ?? "",
                                       confirmedCases: "")
            }
            let confirmedCasesDescription = confirmedCases.isSingular ? Localizables.confirmedDescriptionSingular
                : String(format: Localizables.confirmedDescriptionPlural, confirmedCases.formattedWithSeparator)
            return CountryLocation(lat: lat,
                                   long: long,
                                   markerSize: size,
                                   countryName: figure.countryRegion ?? "",
                                   confirmedCases: confirmedCasesDescription)
        }
    }
    
    private func greatestConfirmedValue(fromFigures figures: [FiguresByCountry]) -> Int {
        let greatestConfirmedFigure = figures.max { last, current in
            let lastConfirmed = last.confirmed ?? 0
            let currentConfirmed = current.confirmed ?? 0
            return lastConfirmed < currentConfirmed
        }
        return greatestConfirmedFigure?.confirmed ?? 0
    }
    
    private func calculateMarkerSize(withValue value: Int, greatestValue: Int) -> CGFloat {
        let percentageSize = value * 150 / greatestValue
        let finalSize = max(CGFloat(percentageSize), CGFloat(20))
        return min(CGFloat(finalSize), CGFloat(150))
    }
}
