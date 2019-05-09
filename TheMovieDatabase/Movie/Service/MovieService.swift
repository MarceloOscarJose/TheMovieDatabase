//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class MovieService: GeneralService {

    func fetchMovies(category: MovieServiceCategory, page: Int, responseHandler: @escaping (_ response: MovieResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: String] = ["page": "\(page)"]

        self.executeRequest(url: category.rawValue, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let movieResult = try JSONDecoder().decode(MovieResult.self, from: data)
                responseHandler(movieResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}

enum MovieServiceCategory: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
}
