//
//  MovieListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieListDelegate: ListViewDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    func listTitle() -> String {
        return ConfigManager.shared.config.listScopes.movie.title
    }

    func scopesList() -> [String] {
        return ConfigManager.shared.config.listScopes.movie.scopes.map({ $0.title })
    }

    func getList(animated: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getMovieList(nextPage: nextPage, scope: scope, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
