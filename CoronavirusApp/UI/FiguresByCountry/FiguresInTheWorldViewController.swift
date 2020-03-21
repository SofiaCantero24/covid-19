//
//  FiguresInTheWorldViewController.swift
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

class FiguresInTheWorldViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var figuresStackView: UIStackView!
    @IBOutlet weak var figuresTableView: UITableView!
    
    var lastSelectedTab: TabType = .confirmed
    let viewModel = FiguresInTheWorldViewModel()
    
    var isFiltering: Bool {
        return searchBar.text?.isEmpty == false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        figuresTableView.delegate = self
        figuresTableView.dataSource = self
        figuresTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "CountryTableViewCell")
        viewModel.getGlobalFigures { globalStats in
            guard let globalStats = globalStats?.stats else { return }
            self.setupTabViews(withGlobalFigurez: globalStats )
        }
        viewModel.getFiguresByCountry {
            self.figuresTableView.reloadData()
        }
        setupSearchView()
    }

    private func setupTabViews(withGlobalFigurez figures: GlobalFigures) {
        guard let confirmedFigure = figures.confirmed,
            let deathsFigure = figures.deaths,
            let recoveredFigure = figures.recovered else { return }
        createTabView(tabViewType: .confirmed, figure: confirmedFigure, selected: true, description: "Confirmed")
        createTabView(tabViewType: .deaths, figure: deathsFigure, selected: false, description: "Deaths")
        createTabView(tabViewType: .recoveries, figure: recoveredFigure, selected: false, description: "Recovered")
    }
    
    private func createTabView(tabViewType: TabType, figure: String, selected: Bool, description: String) {
        guard let tabView = GlobalFigureTabView.loadFirstSubViewFromNib() as? GlobalFigureTabView else { return }
        tabView.setupTabView(tabViewType: tabViewType, figure: figure, selected: selected, description: description)
        figuresStackView.addArrangedSubview(tabView)
        setupGestureRecognizer(inTabView: tabView)
    }
    
    private func setupGestureRecognizer(inTabView tabView: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tabView.addGestureRecognizer(tap)
    }
    
    private func setupSearchView() {
        searchBar.placeholder = "Search countries.."
    }
    
    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        guard let senderView = sender.view else { return }
        if sender.state == .ended {
            let selectedViewTag = senderView.tag
            if selectedViewTag != lastSelectedTab.rawValue,
                let selectedView = figuresStackView.arrangedSubviews[selectedViewTag] as? GlobalFigureTabView,
                let lastSelectedView = figuresStackView.arrangedSubviews[lastSelectedTab.rawValue] as? GlobalFigureTabView {
                selectedView.updateSelected()
                lastSelectedView.updateSelected()
                lastSelectedTab = TabType(rawValue: selectedViewTag) ?? .confirmed
            }
            figuresTableView.reloadData()
        }
    }
}

extension FiguresInTheWorldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryFigures = viewModel.coronavirusWorldFigures[indexPath.row]
        let mapViewModel = MapViewModel(latitude: countryFigures.lat, longitude: countryFigures.long)
        let mapViewController = MapViewController(viewModel: mapViewModel)
        
        let navigationController = UINavigationController(rootViewController: mapViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.popover
        present(navigationController, animated: true, completion: nil)
    }
}

extension FiguresInTheWorldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coronavirusWorldFigures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let figuresList = viewModel.coronavirusWorldFigures
        cell.setupCell(withData: figuresList[indexPath.row], andTabType: lastSelectedTab)
        return cell
    }
}
