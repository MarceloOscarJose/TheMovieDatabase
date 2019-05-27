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
    let scopes = ConfigManager.shared.config.listScopes.movie

    func listTitle() -> String {
        return scopes.title
    }

    func scopesList() -> [String] {
        return scopes.scopes.map({ $0.title })
    }

    func getList(animated: Bool, scope: Int, nextPage: Bool, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getMovieList(nextPage: nextPage, scope: scope, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
