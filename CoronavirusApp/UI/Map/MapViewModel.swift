//
//  MapViewModel.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/21/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class MapViewModel {
    let latitude: Double
    let longitude: Double

    init(latitude: String, longitude: String) {
        self.latitude = Double(latitude) ?? 0.0
        self.longitude = Double(longitude) ?? 0.0
    }
}
