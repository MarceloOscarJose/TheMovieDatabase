//
//  SearchListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 18/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class SearchListDelegate: ListViewDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    func listTitle() -> String {
        return ConfigManager.shared.config.listScopes.search.title
    }

    func scopesList() -> [String] {
        return []
    }

    func getList(animated: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getSearchList(nextPage: nextPage, scope: scope, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }

    func selectRow(id: Int, navController: UINavigationController) {
        navController.pushViewController(DetailViewController(id: id, delegate: ShowDetailDelegate()), animated: true)
    }
}
