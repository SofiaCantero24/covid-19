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
            guard let globalStats = globalFigures?.stats else { return }
            self.addStackViews(globalStats: globalStats)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        figuresAnimation()
    }

    private func addStackViews(globalStats: GlobalFigures) {
        guard let confirmedStats = Int(globalStats.confirmed!),
            let deathStats = Int(globalStats.deaths!),
            let recoveredStats = Int(globalStats.recovered!) else { return }
        let maxFigure = max(confirmedStats, deathStats, recoveredStats)
        setupFigureView(figure: confirmedStats, description: "Confirmed", figureColor: .green, maxFigure: maxFigure)
        setupFigureView(figure: deathStats, description: "Deaths", figureColor: .red, maxFigure: maxFigure)
        setupFigureView(figure: recoveredStats, description: "Recoveries", figureColor: .orange, maxFigure: maxFigure)
        figuresAnimation()
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

    private func figuresAnimation() {
        for view in figuresStackView.arrangedSubviews {
            if let figureView = view as? FigureView {
                figureView.figureAnimation()
            }
        }
    }
}
