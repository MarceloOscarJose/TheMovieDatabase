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

    var snackbar: LPSnackbar!

    var controllerTitle: String!
    let cellIdentifier = "ListCollectionViewCell"
    var showActivityIndicator: Bool = false

    var listData: [ListData] = []
    var listDataFilter: [ListData] = []

    var delegate: ListViewControllerDelegate!

    // MARK: LifeCycle
    init(delegate: ListViewControllerDelegate) {
        super.init(nibName: "ListViewController", bundle: .main)
        self.delegate = delegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = self.delegate.listTitle()
    }

    func getList(animated: Bool = false) {
        clearSearchBar()
        toggleActivityIndicator(show: true)

        self.delegate.getList(animated: animated, type: self.searchBar.selectedScopeButtonIndex, responseHandler: { (resultData) in
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
        searchBar.scopeButtonTitles = self.delegate.scopesList()
        searchBar.delegate = self

        // Collection view setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(gesture)

        getList(animated: true)
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

    func showSnackError(title: String, buttonText: String, completion: @escaping () -> Void) {
        if snackbar != nil {
            snackbar.dismiss()
        }

        snackbar = LPSnackbar(title: title, buttonTitle: buttonText)
        snackbar.view.titleLabel.font = UIFont.systemFont(ofSize: 15)
        snackbar.view.button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        snackbar.show(animated: true) {(undone) in
            if undone {
                completion()
                self.snackbar = nil
            }
        }
    }
}

protocol ListViewControllerDelegate: class {
    func listTitle() -> String
    func scopesList() -> [String]
    func getList(animated: Bool, type: Int, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
    func selectRow(id: Int, navController: UINavigationController)
}
