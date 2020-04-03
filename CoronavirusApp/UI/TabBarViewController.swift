//
//  TabBarViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 1
        tabBar.clipsToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.backgroundColor = .white
        tabBar.items?[0].title = Localizables.tabBarCountries
        tabBar.items?[1].title = Localizables.tabBarGlobal
        tabBar.items?[2].title = Localizables.tabBarMaps
    }
}
