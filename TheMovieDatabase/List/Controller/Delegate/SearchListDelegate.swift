//
//  SearchListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 18/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class SearchListDelegate: ListViewDelegate {

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
        return []
    }

    func getListOnInit() -> Bool {
        return false
    }

    func getList(animated: Bool, scope: Int, nextPage: Bool, query: String, responseHandler: @escaping (_ response: [ListModelData]?) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getList(nextPage: nextPage, query: query, scope: 0, entity: SearchListResponse.self, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
