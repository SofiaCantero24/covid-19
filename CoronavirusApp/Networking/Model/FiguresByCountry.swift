//
//  FiguresByCountry.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/18/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

struct CoronavirusCountries: Mappable {
    var registers: Int
    var data: [FiguresByCountry]
}

struct FiguresByCountry: Mappable {
    var idApi: Int?
    var countryRegion: String?
    var lat: String?
    var long: String?
    var confirmed: Int?
    var deaths: Int?
    var recovered: Int?
}
