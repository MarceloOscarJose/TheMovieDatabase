//
//  MovieViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

enum ListType {
    case movies
    case shows
}

class ListViewController: UIViewController {

    var controllerTitle: String = ""
    var controllerType: ListType = .movies
    let cellIdentifier = "ListCollectionViewCell"

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.ligthBlue
        return refreshControl
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(refreshControl)
        collectionView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = UIColor.ligthBlue
        searchBar.barTintColor = UIColor.white
        searchBar.placeholder = "Search by title"
        return searchBar
    }()

    let model = ListModel()
    var listData: [ListData] = []
    var listDataFilter: [ListData] = []
    var nextPage: Bool = false
    var movieCategory: MovieServiceCategory = .popular
    var showCategory: ShowServiceCategory = .popular

    convenience init(title: String, type: ListType) {
        self.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.white
        self.controllerTitle = title
        self.controllerType = type

        if controllerType == .movies {
            searchBar.scopeButtonTitles = ["Popular", "Top rated", "Upcoming"]
            refreshControl.addTarget(self, action: #selector(getMovies), for: .valueChanged)
            getMovies(animated: true)
        } else {
            searchBar.scopeButtonTitles = ["Popular", "Top rated", "On air"]
            refreshControl.addTarget(self, action: #selector(getShows), for: .valueChanged)
            getShows(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.controllerTitle
    }

    func setupControls() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    @objc func getMovies(animated: Bool = false) {
        model.getMovies(nextPage: nextPage, category: movieCategory, responseHandler: { (resultData) in
            self.listData = resultData
            self.reloadResults(data: resultData, animated: animated)
        }) { (_) in
            print("Can't connect")
        }
    }

    @objc func getShows(animated: Bool = false) {
        model.getShows(nextPage: nextPage, category: showCategory, responseHandler: { (resultData) in
            self.listData = resultData
            self.reloadResults(data: resultData, animated: animated)
        }) { (_) in
            print("Can't connect")
        }
    }

    func reloadResults(data: [ListData], animated: Bool) {

        self.listDataFilter = data
        collectionView.sendSubviewToBack(refreshControl)

        if animated {
            UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }, completion: nil)
        } else {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: Search behaviour
extension ListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        self.movieCategory = selectedScope == 0 ? .popular : selectedScope == 1 ? .topRated : .upcoming
        self.showCategory = selectedScope == 0 ? .popular : selectedScope == 1 ? .topRated : .onair

        reloadResults(data: [], animated: true)

        if self.controllerType == .movies {
            self.getMovies()
        } else {
            self.getShows()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText != "" {
            self.listDataFilter = self.listData.filter({ (movie: ListData) -> Bool in
                if movie.title.contains(searchText) {
                    return true
                }
                return false
            })

            reloadResults(data: self.listDataFilter, animated: true)
        } else {
            reloadResults(data: self.listData, animated: true)
        }
    }
}

// MARK: CollectionView behaviour
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDataFilter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ListCollectionViewCell
        let movie = self.listDataFilter[indexPath.item]
        cell.updateCell(image: movie.poster, title: movie.title, overview: movie.overview, date: movie.releaseDate, average: movie.average)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width
        return CGSize(width: widthPerItem, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
