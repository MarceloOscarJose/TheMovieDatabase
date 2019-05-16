//
//  MovieDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieDelegate: ListViewControllerDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    let scopeTypes: [String] = ["popular", "top_rated", "upcoming"]
    let scopeNames: [String] = ["Popular", "Top rated", "Upcoming"]

    func listTitle() -> String {
        return "Movies"
    }

    func scopesList() -> [String] {
        return scopeNames
    }

    func getList(animated: Bool, type: Int, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        model.getMovieList(nextPage: nextPage, url: "movie/\(scopeTypes[type])", responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }
}
