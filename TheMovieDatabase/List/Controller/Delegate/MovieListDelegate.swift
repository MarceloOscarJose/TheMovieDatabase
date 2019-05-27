//
//  MovieListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieListDelegate: ListViewDelegate {

    let model: ListModel!
    let scope: ConfigData.Scope!

    init(scope: ConfigData.Scope) {
        self.scope = scope
        self.model = ListModel(scope: scope)
    }

    func listTitle() -> String {
        return scope.title
    }

    func scopesList() -> [String] {
        return scope.data.map({ $0.title })
    }

    func getListOnInit() -> Bool {
        return true
    }

    func getList(animated: Bool, scope: Int, nextPage: Bool, query: String, responseHandler: @escaping (_ response: [ListModelData]?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getList(nextPage: nextPage, query: "", scope: scope, entity: MovieListResponse.self, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
