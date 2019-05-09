//
//  MovieViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var nextPage: Bool = false
    let cellIdentifier = "MovieCollectionViewCell"
    let model = MovieModel()
    var movies: [MovieData] = []
    var moviesFilter: [MovieData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        getMovies()
    }

    func setupControls() {
        self.searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
    }

    func getMovies(category: MovieServiceCategory = .popular) {
        model.getMovies(nextPage: nextPage, category: category, responseHandler: { (resultData) in
            self.movies = resultData
            self.reloadResults(data: resultData)
        }) { (_) in
            print("Can't connect")
        }
    }

    func reloadResults(data: [MovieData]) {
        self.moviesFilter = data
        self.collectionView.reloadData()
    }
}

// MARK: Search behaviour
extension MovieViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        let category: MovieServiceCategory = selectedScope == 0 ? .popular : selectedScope == 1 ? .topRated : .upcoming

        reloadResults(data: [])
        self.getMovies(category: category)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.moviesFilter = self.movies.filter({ (movie: MovieData) -> Bool in
            if movie.title.contains(searchText) {
                return true
            }
            return false
        })

        reloadResults(data: self.moviesFilter)
    }
}

// MARK: CollectionView behaviour
extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesFilter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = self.moviesFilter[indexPath.item]
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
