//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ListModel: NSObject {

    let movieService = MovieService()
    let showService = ShowService()

    // Page control
    var moviePage: Int = 1
    var showPage: Int = 1

    func getMovies(nextPage: Bool, category: MovieServiceCategory, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        moviePage += nextPage ? 1 : 0
        movieService.fetchMovies(category: category, page: moviePage, responseHandler: { (result) in
            var list: [ListData] = []
            for element in result.results {
                list.append(ListData(movie: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShows(nextPage: Bool, category: ShowServiceCategory, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        showPage += nextPage ? 1 : 0
        showService.fetchShows(category: category, page: showPage, responseHandler: { (result) in
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
