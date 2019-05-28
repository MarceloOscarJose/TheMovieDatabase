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
    @IBOutlet weak var scrollTopButton: UIButton!

    var controllerTitle: String!
    let cellIdentifier = "ListCollectionViewCell"

    var listData: [ListModelData] = []
    var listDataFilter: [ListModelData] = []

    var delegate: ListViewDelegate!

    // MARK: LifeCycle
    convenience init(delegate: ListViewDelegate) {
        self.init()
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()

        if self.delegate.getListOnInit() {
            getList(animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.delegate.listTitle()
    }

    // MARK: UI Setup
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
        scrollTopButton.isHidden = true
        scrollTopButton.addTarget(self, action: #selector(scrollTopButtonAction), for: .touchUpInside)
    }

    func getList(animated: Bool = false, nextPage: Bool = false, query: String = "") {
        if self.delegate.getListOnInit() {
            clearSearchBar()
            toggleActivityIndicator(show: true)
        }

        self.delegate.getList(animated: animated, scope: self.searchBar.selectedScopeButtonIndex, nextPage: nextPage, query: query, responseHandler: { (resultData) in
            if let result = resultData {
                if nextPage {
                    self.listData.append(contentsOf: result)
                } else {
                    self.listData = result
                }

                self.reloadResults(data: self.listData, animated: animated)
            }

            self.toggleActivityIndicator(show: false)
        }) { (error) in
            self.toggleActivityIndicator(show: false)
            self.showSnackError(title: "Error connecting to service", buttonText: "Retry", view: self.collectionView, completion: {
                self.getList(animated: animated)
            })
        }
    }

    func showKeyboard() {
        searchBar.becomeFirstResponder()
    }

    @objc func hideKeyboard() {
        searchBar.endEditing(true)
    }

    func clearSearchBar() {
        self.searchBar.text = String()
        hideKeyboard()
    }

    func reloadResults(data: [ListModelData], animated: Bool) {
        self.listData = data
        self.listDataFilter = data
        self.toggleActivityIndicator(show: false)
        reloadList(animated: animated)
    }

    func reloadList(animated: Bool) {
        DispatchQueue.main.async {
            if animated {
                UIView.transition(with: self.collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.collectionView.reloadData()
                }, completion: nil)
            } else {
                self.collectionView.reloadData()
            }
        }
    }

    @objc func scrollTopButtonAction() {
        scrollToTop(animated: true)
    }

    func scrollToTop(animated: Bool = true) {
        if self.collectionView.numberOfItems(inSection: 0) > 0 {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: animated)
        }
    }
}

protocol ListViewDelegate: class {
    func listTitle() -> String
    func scopesList() -> [String]
    func getListOnInit() -> Bool
    func getList(animated: Bool, scope: Int, nextPage: Bool, query: String, responseHandler: @escaping (_ response: [ListModelData]?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
