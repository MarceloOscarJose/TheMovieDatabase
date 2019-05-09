//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ListModel: NSObject {

    let listService = ListService()

    // Page control
    var moviePage: Int = 1
    var showPage: Int = 1

    func getMovies(nextPage: Bool, category: MovieCategory, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        moviePage += nextPage ? 1 : 0
        listService.fetchMovies(category: category, page: moviePage, responseHandler: { (result) in
            var list: [ListData] = []
            for element in result.results {
                list.append(ListData(movie: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShows(nextPage: Bool, category: ShowCategory, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        showPage += nextPage ? 1 : 0
        listService.fetchShows(category: category, page: showPage, responseHandler: { (result) in
            var list: [ListData] = []
            for element in result.results {
                list.append(ListData(show: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}
