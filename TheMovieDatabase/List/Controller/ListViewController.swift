//
//  ListViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 09/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    var controllerTitle: String!
    let cellIdentifier = "ListCollectionViewCell"

    var listData: [ListModelData] = []
    var listDataFilter: [ListModelData] = []

    var delegate: ListViewDelegate!
    var searchDelegate: ListViewSearchDelegate!

    // MARK: LifeCycle
    convenience init(delegate: ListViewDelegate) {
        self.init()
        self.delegate = delegate
    }

    convenience init(delegate: ListViewDelegate, searchDelegate: ListViewSearchDelegate) {
        self.init()
        self.delegate = delegate
        self.searchDelegate = searchDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        if self.delegate.scopesList().count > 0 {
            getList(animated: true)
        } else {
            toggleActivityIndicator(show: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.delegate.listTitle()
    }

    func getList(animated: Bool = false) {
        clearSearchBar()
        toggleActivityIndicator(show: true)

        self.delegate.getList(animated: animated, scope: self.searchBar.selectedScopeButtonIndex, responseHandler: { (resultData) in
            self.listData = resultData
            self.reloadResults(data: resultData, animated: animated)
            self.toggleActivityIndicator(show: false)
        }) { (error) in
            self.toggleActivityIndicator(show: false)
            self.showSnackError(title: "Error connecting to service", buttonText: "Retry", completion: {
                self.getList(animated: animated)
            })
        }
    }

    func setupControls() {
        // Search bar setup
        searchBar.scopeButtonTitles = self.delegate.scopesList()
        searchBar.delegate = self

        // Collection view setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(gesture)
    }

    @objc func hideKeyboard() {
        searchBar.endEditing(true)
    }

    func clearSearchBar() {
        self.searchBar.text = String()
        hideKeyboard()
    }

    func reloadResults(data: [ListModelData], animated: Bool) {
        self.listDataFilter = data
        self.toggleActivityIndicator(show: false)

        if animated {
            UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadData()
            }, completion: nil)
        } else {
            self.collectionView.reloadData()
        }
    }
}

protocol ListViewDelegate: class {
    func listTitle() -> String
    func scopesList() -> [String]
    func getList(animated: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
    func selectRow(id: Int, navController: UINavigationController)
}

protocol ListViewSearchDelegate: class {
    func searchByTitle(title: String, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
