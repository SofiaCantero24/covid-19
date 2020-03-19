//
//  CoronavirusViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

enum TabType: Int {
    case confirmed = 0
    case deaths = 1
    case recoveries = 2
}

class CoronavirusViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var figuresStackView: UIStackView!
    
    //Confirmed
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var confirmedFigure: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var confirmedSeparator: UIView!
    
    //Deaths
    @IBOutlet weak var deathsView: UIView!
    @IBOutlet weak var deathsFigure: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var deathsSeparator: UIView!
    
    //Recoveries
    @IBOutlet weak var recoveriesView: UIView!
    @IBOutlet weak var recoveriesFigure: UILabel!
    @IBOutlet weak var recoveriesLabel: UILabel!
    @IBOutlet weak var recoveriesSeparator: UIView!
    
    var lastSelectedTab: TabType = .confirmed
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGestureRecognizer(withType: .confirmed)
        setupGestureRecognizer(withType: .deaths)
        setupGestureRecognizer(withType: .recoveries)
    }

    private func setupGestureRecognizer(withType type: TabType) {
        let tapView = getGestureView(withType: type)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tapView.addGestureRecognizer(tap)
    }

    private func getGestureView(withType type: TabType) -> UIView {
        switch type {
        case .confirmed:
            return confirmedView
        case .deaths:
            return deathsView
        case .recoveries:
            return recoveriesView
        }
    }
    
    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else { return }
        if sender.state == .ended {
            let selectedViewTag = senderView.tag
            switch selectedViewTag {
            case TabType.confirmed.rawValue:
                confirmedFigure.textColor = .orange
                confirmedSeparator.backgroundColor = .orange
            case TabType.deaths.rawValue:
                deathsFigure.textColor = .orange
                deathsSeparator.backgroundColor = .orange
            case TabType.recoveries.rawValue:
                recoveriesFigure.textColor = .orange
                recoveriesSeparator.backgroundColor = .orange
            default:
                break
            }
            handleLastSelectedTab(selectedViewTag)
        }
    }
    
    private func handleLastSelectedTab(_ currentSelected: Int) {
        guard lastSelectedTab.rawValue != currentSelected else { return }
        switch lastSelectedTab {
        case .confirmed:
            confirmedFigure.textColor = .lightGray
            confirmedSeparator.backgroundColor = .lightGray
        case .deaths:
            deathsFigure.textColor = .lightGray
            deathsSeparator.backgroundColor = .lightGray
        case .recoveries:
            recoveriesFigure.textColor = .lightGray
            recoveriesSeparator.backgroundColor = .lightGray
        }
        lastSelectedTab = TabType(rawValue: currentSelected) ?? .confirmed
    }
}
