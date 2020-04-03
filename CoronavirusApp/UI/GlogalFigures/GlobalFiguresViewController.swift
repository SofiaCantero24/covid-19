//
//  GlobalFiguresViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GlobalFiguresViewController: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var figuresStackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let viewModel = GlobalFiguresViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackgroundView()
        setupFiguresStackView()
        setupBannerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        figuresAnimation()
        refreshButtonAnimation()
    }
    
    // MARK: - Private Methods
    private func setupBannerView() {
        bannerView.adUnitID = "ca-app-pub-5249500779728690/8295761298"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    private func setupBackgroundView() {
        contentView.backgroundColor = .selected
        backgroundView.backgroundColor = .selected
        titleLabel.text = Localizables.appTitle
        subtitleLabel.text = Localizables.globalFiguresSubtitle
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
        refreshButton.imageEdgeInsets = UIEdgeInsets(top: Constants.imageInsets,
                                                     left: Constants.imageInsets,
                                                     bottom: Constants.imageInsets,
                                                     right: Constants.imageInsets)
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
        setupFigureView(figure: confirmedStats,
                        description: Localizables.confirmedCases,
                        figureColor: .green)
        setupFigureView(figure: deathStats,
                        description: Localizables.deathCases,
                        figureColor: .red)
        setupFigureView(figure: recoveredStats,
                        description: Localizables.recoveredCases,
                        figureColor: .orange)
        figuresAnimation()
    }
    
    private func setupFigureView(figure: Int, description: String, figureColor: UIColor) {
        let viewModel = FigureViewModel(figure: figure,
                                        description: description,
                                        figureColor: figureColor)
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
        viewModel.getGlobalFigures { response in
            let newFigures = [Int(response?.stats?.confirmed ?? "") ?? 0,
                              Int(response?.stats?.deaths ?? "") ?? 0,
                              Int(response?.stats?.recovered ?? "") ?? 0]
            for (index, view) in self.figuresStackView.arrangedSubviews.enumerated() {
                if let figureView = view as? FigureView {
                    figureView.figureAnimation(withMaxFigure: newFigures[index])
                }
            }
        }
        
        refreshButtonAnimation()
    }
}
