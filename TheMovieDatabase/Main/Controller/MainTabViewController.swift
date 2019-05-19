//
//  MainTabViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    let scopes = ConfigManager.shared.config.listScopes

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        let moviesList = ListViewController(delegate: MovieListDelegate())
        let showsList = ListViewController(delegate: ShowListDelegate())
        let searchList = ListViewController(delegate: SearchListDelegate())

        moviesList.tabBarItem = UITabBarItem(title: scopes.movie.title, image: UIImage(named: scopes.movie.icon), tag: 0)
        showsList.tabBarItem = UITabBarItem(title: scopes.show.title, image: UIImage(named: scopes.show.icon), tag: 1)
        searchList.tabBarItem = UITabBarItem(title: scopes.search.title, image: UIImage(named: scopes.search.icon), tag: 2)

        self.viewControllers = [moviesList, showsList, searchList]
    }
}
