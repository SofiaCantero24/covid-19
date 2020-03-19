//
//  GlobalFiguresViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class GlobalFiguresViewController: UIViewController {
    @IBOutlet weak var figuresStackView: UIStackView!
    
    let viewModel = GlobalFiguresViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getGlobalFigures { globalFigures in
            guard let globalFigures = globalFigures else {
                let mockDescription = GlobalFigures(confirmed: 214915,
                                                    deaths: 8733,
                                                    recoveries: 83313)
                let mockFigures = GlobalStats(stats: mockDescription)
                self.addStackViews(globalStats: mockFigures.stats)
                return
            }
            self.addStackViews(globalStats: globalFigures.stats)
        }
    }

    private func addStackViews(globalStats: GlobalFigures) {
        let maxFigure = max(globalStats.confirmed, globalStats.deaths, globalStats.recoveries)
        setupFigureView(figure: globalStats.confirmed, description: "Confirmed", figureColor: .green, maxFigure: maxFigure)
        setupFigureView(figure: globalStats.deaths, description: "Deaths", figureColor: .red, maxFigure: maxFigure)
        setupFigureView(figure: globalStats.recoveries, description: "Recoveries", figureColor: .yellow, maxFigure: maxFigure)
    }
    
    private func setupFigureView(figure: Int, description: String, figureColor: UIColor, maxFigure: Int) {
        let viewModel = FigureViewModel(figure: figure,
                                        description: description,
                                        figureColor: figureColor,
                                        maxFigure: maxFigure)
        let figureView = FigureView.loadFirstSubViewFromNib() as! FigureView
        figureView.viewModel = viewModel
        figureView.setupViewLabels()
        figuresStackView.addArrangedSubview(figureView)
    }

}
