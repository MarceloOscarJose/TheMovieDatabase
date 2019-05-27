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
    let movieScopes = ConfigManager.shared.config.listScopes.movie.scopes
    let showScopes = ConfigManager.shared.config.listScopes.show.scopes
    let searchScope = ConfigManager.shared.config.listScopes.search

    var moviePages: [Int] = []
    var showPages: [Int] = []
    var searchPage: Int = 1

    override init() {
        moviePages = Array(repeating: 1, count: movieScopes.count)
        showPages = Array(repeating: 1, count: showScopes.count)
    }

    func getMovieList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        moviePages[scope] += nextPage ? 1 : 0

        listService.fetchList(url: movieScopes[scope].url, entity: MovieListResponse.self, page: moviePages[scope], params: nil, responseHandler: { (result) in
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

        showPages[scope] += nextPage ? 1 : 0

        listService.fetchList(url: showScopes[scope].url, entity: ShowListResponse.self, page: showPages[scope], params: nil, responseHandler: { (result) in
            var list: [ListModelData] = []
            for element in (result as! ShowListResponse).results {
                list.append(ListModelData(show: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getSearchList(nextPage: Bool, searchText: String, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let searchParams = ["query" : searchText]
        searchPage += nextPage ? 1 : 0

        listService.fetchList(url: searchScope.url, entity: SearchListResponse.self, page: searchPage, params: searchParams, responseHandler: { (result) in
            var list: [ListModelData] = []
            for element in (result as! SearchListResponse).results {
                list.append(ListModelData(result: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}
