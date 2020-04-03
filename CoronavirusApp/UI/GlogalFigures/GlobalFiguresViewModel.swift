//
//  GlobalFiguresViewModel.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

class GlobalFiguresViewModel {
    var goblalFigures: GlobalStats?
    let colors: [UIColor] = [.green, .red, .yellow]
    
    func getGlobalFigures(completion: @escaping (GlobalStats?) -> Void) {
        SAGlobalFiguresServiceResult.shared.getGlobalFigures(success: { (response) in
            print(response)
            completion(response)
            //self?.getFiguresByCountry()
        }) { (error) in
            print(error)
        }
    }
}
