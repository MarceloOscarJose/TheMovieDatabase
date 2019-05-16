//
//  MainTabViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        let moviesList = ListViewController(delegate: MovieDelegate())
        let showsList = ListViewController(delegate: ShowDelegate())

        moviesList.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies"), tag: 0)
        showsList.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(named: "shows"), tag: 1)

        self.viewControllers = [moviesList, showsList]
    }
}
