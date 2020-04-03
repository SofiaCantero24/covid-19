//
//  GlobalFigureTabView.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/21/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class GlobalFigureTabView: UIView {
    @IBOutlet weak var figuresLabel: UILabel!
    @IBOutlet weak var figuresDescriptionLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var selected: Bool = false
    
    // MARK: - Public Methods
    func updateSelected() {
        selected = !selected
        setupColor()
    }
    
    func setupTabView(tabViewType: TabType, figure: String, selected: Bool, description: String) {
        self.selected = selected
        tag = tabViewType.rawValue
        setupColor()
        setupLabels(WithFigure: figure, andDescription: description)
    }
    
    // MARK: - Private Methods
    private func setupColor() {
        let color: UIColor = selected ? .selected : .lightGray
        figuresLabel.textColor = color
        figuresDescriptionLabel.textColor = color
        separatorView.backgroundColor = color
    }
    
    private func setupLabels(WithFigure figure: String, andDescription description: String) {
        figuresLabel.text = figure
        figuresDescriptionLabel.text = description
        figuresLabel.font = .montserratSemiBold20
        figuresDescriptionLabel.font = .montserratMedium17
    }
}
