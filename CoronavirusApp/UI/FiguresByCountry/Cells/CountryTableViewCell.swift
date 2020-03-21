//
//  CountryTableViewCell.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/20/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var figuresLabel: UILabel!
    
    func setupCell(withData data: FiguresByCountry, andTabType tabType: TabType) {
        countryNameLabel.text = data.countryRegion
        switch tabType {
        case .confirmed:
            figuresLabel.text = data.confirmed
        case .deaths:
            figuresLabel.text = data.deaths
        case .recoveries:
            figuresLabel.text = data.recovered
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
