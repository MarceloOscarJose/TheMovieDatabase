//
//  ShowListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ShowListDelegate: ListViewControllerDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    let scopeTypes: [String] = ["popular", "top_rated", "on_the_air"]

    func listTitle() -> String {
        return "TV Shows"
    }

    func scopesList() -> [String] {
        return ["Popular", "Top rated", "On air"]
    }

    func getList(animated: Bool, type: Int, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getShowList(nextPage: nextPage, url: "tv/\(scopeTypes[type])", responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }

    func selectRow(id: Int) {
        
    }
}