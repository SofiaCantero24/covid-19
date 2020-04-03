//
//  FiguresInTheWorldViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import PKHUD

class FiguresInTheWorldViewController: UIViewController {
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var figuresStackView: UIStackView!
    @IBOutlet weak var figuresTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var lastSelectedTab: TabType = .confirmed
    let viewModel = FiguresInTheWorldViewModel()
    var searchBarShown = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        setupBackgoundView()
        setupTabViews()
        setupSearchView()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.coronavirusWorldFigures.isEmpty {
            HUD.show(.progress)
        }
    }
    
    // MARK:- Private Methods
    private func setupBackgoundView() {
        backgroundView.backgroundColor = .selected
        titleLabel.text = Localizables.appTitle
        subtitleLabel.text = Localizables.figuresByCountrySubtitle
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
        searchButton.tintColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentCornerRadious
    }
    
    private func setupTabViews() {
        guard let figures = viewModel.globalStats?.stats else { return }
        guard let confirmedFigure = Int(figures.confirmed ?? ""),
            let deathsFigure = Int(figures.deaths ?? ""),
            let recoveredFigure = Int(figures.recovered ?? "") else { return }
        self.createTabView(tabViewType: .confirmed,
                           figure: confirmedFigure.formattedWithSeparator,
                           selected: true,
                           description: Localizables.confirmedCases)
        self.createTabView(tabViewType: .deaths,
                           figure: deathsFigure.formattedWithSeparator,
                           selected: false,
                           description: Localizables.deathCases)
        self.createTabView(tabViewType: .recoveries,
                           figure: recoveredFigure.formattedWithSeparator,
                           selected: false,
                           description: Localizables.recoveredCases)
    }
    
    private func createTabView(tabViewType: TabType, figure: String, selected: Bool, description: String) {
        guard let tabView = GlobalFigureTabView.loadFirstSubViewFromNib() as? GlobalFigureTabView else { return }
        tabView.setupTabView(tabViewType: tabViewType, figure: figure, selected: selected, description: description)
        figuresStackView.addArrangedSubview(tabView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tabView.addGestureRecognizer(tap)
    }
    
    private func setupSearchView() {
        searchBar.placeholder = Localizables.searchBarPlaceholder
        searchBarHeightConstraint.constant = 0
        searchBar.delegate = self
        searchButton.imageEdgeInsets = UIEdgeInsets(top: Constants.imageInsets,
                                                    left: Constants.imageInsets,
                                                    bottom: Constants.imageInsets,
                                                    right: Constants.imageInsets)
    }
    
    private func setupTableView() {
        figuresTableView.dataSource = self
        figuresTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "CountryTableViewCell")
        
        viewModel.getFiguresByCountry {
            self.figuresTableView.reloadData()
            HUD.hide()
        }
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
    
    // MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.searchBarHeightConstraint.constant = self.searchBarShown ? 0 : Constants.searchBarHeight
            self.view.layoutIfNeeded()
        }
        searchBarShown = !searchBarShown
        figuresTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FiguresInTheWorldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentFiguresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(withData: viewModel.currentFiguresList[indexPath.row], andTabType: lastSelectedTab)
        return cell
    }
    
}

// MARK: - UISearchBarDelegate
extension FiguresInTheWorldViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterFigures(byString: searchText)
        figuresTableView.reloadData()
    }
}
