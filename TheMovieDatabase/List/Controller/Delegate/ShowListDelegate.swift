//
//  ShowListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ShowListDelegate: ListViewDelegate {

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

    func getList(animated: Bool, scope: Int, nextPage: Bool, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getList(nextPage: nextPage, query: "", scope: scope, entity: ShowListResponse.self, responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
