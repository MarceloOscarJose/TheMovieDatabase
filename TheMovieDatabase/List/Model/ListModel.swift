//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ListModel: NSObject {

    let listService = ListService()

    // Scope vars
    let movieScopeTypes: [String] = ["movie/popular", "movie/top_rated", "movie/upcoming"]
    let showScopeTypes: [String] = ["tv/popular", "tv/top_rated", "tv/on_the_air"]

    func getMovieList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        listService.fetchList(url: movieScopeTypes[scope], entity: MovieListResponse.self, page: 1, responseHandler: { (result) in
            var list: [ListModelData] = []
            for element in (result as! MovieListResponse).results {
                list.append(ListModelData(movie: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShowList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        listService.fetchList(url: showScopeTypes[scope], entity: ShowListResponse.self, page: 1, responseHandler: { (result) in
            var list: [ListModelData] = []
            for element in (result as! ShowListResponse).results {
                list.append(ListModelData(show: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}
