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
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if self.collectionView.numberOfItems(inSection: 0) > 0 {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }

        reloadResults(data: [], animated: true)
        self.fetchList()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard !searchText.isEmpty else { reloadResults(data: self.listData, animated: true); return }
        self.listDataFilter = self.listData.filter({ (list: ListData) -> Bool in
            return list.title.lowercased().contains(searchText.lowercased())
        })

        reloadResults(data: self.listDataFilter, animated: true)
    }
}
