//
//  GlobalFiguresViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class GlobalFiguresViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var figuresStackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let viewModel = GlobalFiguresViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackgroundView()
        setupFiguresStackView()
        refreshButton.imageEdgeInsets = UIEdgeInsets(top: Constants.imageInsets,
                                                     left: Constants.imageInsets,
                                                     bottom: Constants.imageInsets,
                                                     right: Constants.imageInsets)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        figuresAnimation()
        refreshButtonAnimation()
    }
    
    // MARK: - Private Methods
    private func setupBackgroundView() {
        contentView.backgroundColor = .selected
        backgroundView.backgroundColor = .selected
        titleLabel.text = "COVID-19"
        subtitleLabel.text = "Global Figures"
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
    }
    
    private func setupFiguresStackView() {
        viewModel.getGlobalFigures { globalFigures in
            guard let globalStats = globalFigures?.stats else { return }
            self.addStackViews(globalStats: globalStats)
        }
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
    
    private func refreshButtonAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.refreshButton.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        })
    }
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        for view in figuresStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        setupFiguresStackView()
        figuresAnimation()
        refreshButtonAnimation()
    }
}
