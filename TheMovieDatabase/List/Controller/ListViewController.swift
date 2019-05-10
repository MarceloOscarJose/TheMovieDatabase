//
//  ListViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 09/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import LPSnackbar

class ListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var controllerTitle: String!
    let cellIdentifier = "ListCollectionViewCell"
    var showActivityIndicator: Bool = false

    let model = ListModel()
    var listData: [ListData] = []
    var listDataFilter: [ListData] = []
    var nextPage: Bool = false
    var listSection: ListCategory.section!
    var listType: ListCategory.type = .Popular

    convenience init(title: String, type: ListCategory.section) {
        self.init(nibName: nil, bundle: nil)
        self.controllerTitle = title
        self.listSection = type
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getList(animated: true)
        setupControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.controllerTitle
    }

    func toggleActivityIndicator(show: Bool) {
        showActivityIndicator = show
        if show {
            let tinyDelay = DispatchTime.now() + Double(Int64(0.2 * Float(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: tinyDelay) {
                if self.showActivityIndicator {
                    self.activityIndicator.isHidden = !show
                    self.activityIndicator.startAnimating()
                }
            }
        } else {
            self.activityIndicator.isHidden = !show
            self.activityIndicator.stopAnimating()
        }
    }

    func setupControls() {
        // Search bar setup
        searchBar.scopeButtonTitles?.append(listSection == .Movie ? "Upcoming" : "On air")
        searchBar.delegate = self

        // Collection view setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }

    @objc func getList(animated: Bool = false) {
        clearSearchBar()
        toggleActivityIndicator(show: true)

        model.getList(nextPage: nextPage, section: listSection, type: listType, responseHandler: { (resultData) in
            self.listData = resultData
            self.reloadResults(data: resultData, animated: animated)
            self.toggleActivityIndicator(show: false)
        }) { (error) in
            self.toggleActivityIndicator(show: false)

            let snackbar = LPSnackbar(title: "Error connecting to service", buttonTitle: "Retry")
            snackbar.show(animated: true) {(undone) in
                if undone {
                    self.getList(animated: animated)
                }
            }
        }
    }

    @objc func hideKeyboard() {
        searchBar.endEditing(true)
    }

    func clearSearchBar() {
        self.searchBar.text = ""
        hideKeyboard()
    }

    func reloadResults(data: [ListData], animated: Bool) {
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
