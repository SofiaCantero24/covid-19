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
    @IBOutlet weak var contentViewCell: UIView!
    
    // MARK: - Public Methods
    func setupCell(withData data: FiguresByCountry, andTabType tabType: TabType) {
        setupContentViewCell()
        setupLabels()
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
    
    // MARK: - Private Methods
    private func setupContentViewCell() {
        contentViewCell.clipsToBounds = true
        contentViewCell.layer.cornerRadius = Constants.contentCornerRadious
        contentViewCell.backgroundColor = .lightShadow
    }
    
    private func setupLabels() {
        countryNameLabel.font = .montserratMedium15
        figuresLabel.font = .montserratMedium15
        countryNameLabel.textColor = .darkGray
        figuresLabel.textColor = .darkGray
    }
}
