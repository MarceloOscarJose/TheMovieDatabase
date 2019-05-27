//
//  MainTabViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    let scopes = ConfigManager.shared.config.getSectionScopes()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        let movieScope = ConfigManager.shared.config.getSectionScope(section: "movies")
        let showScope = ConfigManager.shared.config.getSectionScope(section: "shows")
        let searchScope = ConfigManager.shared.config.getSectionScope(section: "search")

        let moviesList = ListViewController(delegate: MovieListDelegate(scope: movieScope))
        let showsList = ListViewController(delegate: ShowListDelegate(scope: showScope))

        let searchDelegate = SearchListDelegate(scope: searchScope)
        let searchList = ListViewController(delegate: searchDelegate, searchDelegate: searchDelegate)

        moviesList.tabBarItem = UITabBarItem(title: movieScope.title, image: UIImage(named: movieScope.id), tag: 0)
        showsList.tabBarItem = UITabBarItem(title: showScope.title, image: UIImage(named: showScope.id), tag: 1)
        searchList.tabBarItem = UITabBarItem(title: searchScope.title, image: UIImage(named: searchScope.id), tag: 2)

        self.viewControllers = [moviesList, showsList, searchList]
    }
}
