//
//  ShowListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowListDelegate: ListViewDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    func listTitle() -> String {
        return ConfigManager.sharedInstance.listScopes.show.title
    }

    func scopesList() -> [String] {
        return ConfigManager.sharedInstance.listScopes.show.scopes.map({ $0.title })
    }

    func getList(animated: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getShowList(nextPage: nextPage, scope: scope, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }

    func selectRow(id: Int, navController: UINavigationController) {
        navController.pushViewController(DetailViewController(id: id, delegate: ShowDetailDelegate()), animated: true)
    }
}
