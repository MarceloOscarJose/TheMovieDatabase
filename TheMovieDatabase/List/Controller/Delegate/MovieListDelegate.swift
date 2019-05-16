//
//  MovieListDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieListDelegate: ListViewControllerDelegate {

    let model = ListModel()
    var nextPage: Bool = false

    let scopeTypes: [String] = ["popular", "top_rated", "upcoming"]

    func listTitle() -> String {
        return "Movies"
    }

    func scopesList() -> [String] {
        return ["Popular", "Top rated", "Upcoming"]
    }

    func getList(animated: Bool, type: Int, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        model.getMovieList(nextPage: nextPage, url: "movie/\(scopeTypes[type])", responseHandler: { (resultData) in
            responseHandler(resultData)
        }) { (error) in
            errorHandler(error)
        }
    }

    func selectRow(id: Int, navController: UINavigationController) {
        navController.pushViewController(DetailViewController(id: id, delegate: MovieDetailDelegate()), animated: true)
    }
}
