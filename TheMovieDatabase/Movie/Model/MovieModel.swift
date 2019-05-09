//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieModel: NSObject {

    let service = MovieService()

    // Page control
    var page: Int = 1
    var nextPage: Bool = false

    func getMovies(nextPage: Bool, category: MovieServiceCategory, responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        page += nextPage ? 1 : 0
        service.fetchMovies(category: category, page: page, responseHandler: { (result) in
            responseHandler(self.parseMovieResult(result))
        }) { (error) in
            errorHandler(error)
        }
    }

    fileprivate func parseMovieResult(_ movieResult: MovieResult) -> [MovieData] {
        var movies: [MovieData] = []

        for movie in movieResult.results {
            movies.append(MovieData(movie: movie))
        }

        return movies
    }
}
