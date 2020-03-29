//
//  FigureView.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import EFCountingLabel

class FigureView: UIView {
    @IBOutlet weak var figureLabel: EFCountingLabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: FigureViewModel!
    var current = 0
    let animationDuration: Double = 2
    let animationStartDate = Date()
    var displayLink: CADisplayLink?

    func setupViewLabels() {
        clipsToBounds = true
        layer.cornerRadius = 25
        figureLabel.text = "\(0)"
        figureLabel.textColor = viewModel.figureColor
        descriptionLabel.text = viewModel.description.description
        descriptionLabel.textColor = viewModel.figureColor
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        figureLabel.setUpdateBlock { value, label in
            label.text = formatter.string(from: NSNumber(value: Int(value))) ?? ""
        }
        figureLabel.counter.timingFunction = EFTimingFunction.easeOut(easingRate: 3)
    }
    
    func figureAnimation() {
        figureLabel.countFromZeroTo(CGFloat(viewModel.figure))
    }
}
