//
//  FigureView.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class FigureView: UIView {
    @IBOutlet weak var figureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: FigureViewModel?
    
    func setupViewLabels() {
        figureLabel.text = viewModel?.figure.description
        figureLabel.textColor = viewModel?.figureColor
        descriptionLabel.text = viewModel?.description.description
        descriptionLabel.textColor = viewModel?.figureColor
    }
}
