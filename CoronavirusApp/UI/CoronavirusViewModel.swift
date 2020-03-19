//
//  CoronavirusViewModel.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class CoronavirusViewModel {
    var goblalFigures: GlobalFigures?

    func getGlobalFigures() {
        GetGlobalFigures().execute(success: { goblalFigures in
            self.goblalFigures = goblalFigures
        }) { error in
            debugPrint(error)
        }
    }
}
