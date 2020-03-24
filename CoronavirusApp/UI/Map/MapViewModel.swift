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
    let id: String
    let markerSize: CGFloat
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
            guard let lat = Double(figure.lat), let long = Double(figure.long) else {
                return CountryLocation(lat: 0, long: 0, id: figure.idApi, markerSize: size)
            }
            return CountryLocation(lat: lat, long: long, id: figure.idApi, markerSize: size)
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
        let calculatedSize = confirmedValue * 150 / greatestValue
        let finalSize = calculatedSize < 20 ? ( calculatedSize <= 1 ? 20 : 5 * calculatedSize ) : calculatedSize
        return CGFloat(finalSize)
    }
}
