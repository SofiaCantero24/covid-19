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
    
    var selected: Bool = false
    
    // MARK: - Public Methods
    func updateSelected() {
        selected = !selected
        setupColor()
    }
    
    func setupTabView(tabViewType: TabType, figure: String, selected: Bool, description: String) {
        self.selected = selected
        figuresLabel.text = figure
        figuresDescriptionLabel.text = description
        setupColor()
        tag = tabViewType.rawValue
    }
    
    // MARK: - Private Methods
    private func setupColor() {
        let color: UIColor = selected ? .selected : .deselected
        figuresLabel.textColor = color
        figuresDescriptionLabel.textColor = color
    }
}
