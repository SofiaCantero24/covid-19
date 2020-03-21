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
    
    var viewModel: FigureViewModel!
    var current = 0
    let animationDuration: Double = 2
    let animationStartDate = Date()
    var displayLink: CADisplayLink?

    func setupViewLabels() {
        figureLabel.text = "\(0)"
        figureLabel.textColor = viewModel.figureColor
        descriptionLabel.text = viewModel.description.description
        descriptionLabel.textColor = viewModel.figureColor
    }
    
    func figureAnimation() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc
    func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration {
            figureLabel.text = "\(viewModel.figure)"
            displayLink?.isPaused = true
            displayLink?.invalidate()
            displayLink = nil
        } else {
            let percentage = elapsedTime / animationDuration
            let value = Int(percentage * Double(viewModel.figure))
            figureLabel.text = "\(value)"
        }
    }
}
