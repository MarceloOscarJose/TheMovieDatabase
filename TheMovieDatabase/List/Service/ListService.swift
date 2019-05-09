//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ListService: GeneralService {

    func fetchMovies(category: MovieCategory, page: Int, responseHandler: @escaping (_ response: MovieResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: String] = ["page": "\(page)"]

        self.executeRequest(url: category.rawValue, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let listResult = try JSONDecoder().decode(MovieResult.self, from: data)
                responseHandler(listResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }

    func fetchShows(category: ShowCategory, page: Int, responseHandler: @escaping (_ response: ShowResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: String] = ["page": "\(page)"]

        self.executeRequest(url: category.rawValue, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let listResult = try JSONDecoder().decode(ShowResult.self, from: data)
                responseHandler(listResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}

enum MovieCategory: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
}

enum ShowCategory: String {
    case popular = "tv/popular"
    case topRated = "tv/top_rated"
    case onair = "tv/on_the_air"
}
