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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    var lastSelectedTab: TabType = .confirmed
    let viewModel = FiguresInTheWorldViewModel()
    
    var isFiltering: Bool {
        return searchBar.text?.isEmpty == false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        setupTabViews()
        setupSearchView()
        setupTableView()
    }
    
    private func setupTableView() {
        figuresTableView.delegate = self
        figuresTableView.dataSource = self
        figuresTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "CountryTableViewCell")
        viewModel.getFiguresByCountry {
            self.figuresTableView.reloadData()
        }
    }

    private func setupTabViews() {
        viewModel.getGlobalFigures { globalStats in
            guard let figures = globalStats?.stats else { return }
            guard let confirmedFigure = Int(figures.confirmed ?? ""),
                let deathsFigure = Int(figures.deaths ?? ""),
                let recoveredFigure = Int(figures.recovered ?? "") else { return }
            self.createTabView(tabViewType: .confirmed,
                               figure: confirmedFigure.formattedWithSeparator,
                               selected: true,
                               description: "Confirmed")
            self.createTabView(tabViewType: .deaths,
                               figure: deathsFigure.formattedWithSeparator,
                               selected: false,
                               description: "Deaths")
            self.createTabView(tabViewType: .recoveries,
                               figure: recoveredFigure.formattedWithSeparator,
                               selected: false,
                               description: "Recovered")
        }
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
        searchBarHeightConstraint.constant = 0
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
                viewModel.orderBy(tabType: lastSelectedTab)
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
