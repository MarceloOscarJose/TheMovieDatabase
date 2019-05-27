//
//  ListViewController+SearchBar.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 10/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

// MARK: Search behaviour
extension ListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        hideKeyboard()

        if !self.delegate.getListOnInit() {
            guard let searchText = searchBar.text, !searchText.isEmpty else { return }
            toggleActivityIndicator(show: true)
            reloadResults(data: [], animated: false)
            self.scrollToTop()

            self.delegate.getList(animated: true, scope: 0, nextPage: false, query: searchText, responseHandler: { (resultData) in
                if let result = resultData {
                    self.reloadResults(data: result, animated: true)
                }
                self.toggleActivityIndicator(show: false)
            }) { (error) in
                self.toggleActivityIndicator(show: false)
                self.showSnackError(title: "Can't find results", buttonText: "Clear", view: self.collectionView, completion: {
                    self.clearSearchBar()
                    self.showKeyboard()
                })
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scrollToTop()
        reloadResults(data: [], animated: true)
        getList()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.delegate.getListOnInit() {
            guard !searchText.isEmpty else { reloadResults(data: listData, animated: true); return }
            listDataFilter = self.listData.filter({ (list: ListModelData) -> Bool in
                return list.title.lowercased().contains(searchText.lowercased())
            })

            reloadList(animated: true)
        }
    }
}
