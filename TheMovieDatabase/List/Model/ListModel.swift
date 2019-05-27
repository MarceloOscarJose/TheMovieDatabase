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

    var params: [String: String] = ["page" : "1"]

    override init() {
        moviePages = Array(repeating: 1, count: movieScopes.count)
        showPages = Array(repeating: 1, count: showScopes.count)
    }

    func getMovieList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        moviePages[scope] = nextPage ? moviePages[scope] + 1 : 1
        params["page"] = "\(moviePages[scope])"

        listService.fetchList(url: movieScopes[scope].url, entity: MovieListResponse.self, params: params, responseHandler: { (result) in
            let list: [ListModelData] = (result as! MovieListResponse).results.map( { ListModelData(movie: $0) })
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShowList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        showPages[scope] = nextPage ? moviePages[scope] + 1 : 1
        params["page"] = "\(showPages[scope])"

        listService.fetchList(url: showScopes[scope].url, entity: ShowListResponse.self, params: params, responseHandler: { (result) in
            let list: [ListModelData] = (result as! ShowListResponse).results.map( { ListModelData(show: $0) })
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getSearchList(nextPage: Bool, searchText: String, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        searchPage += nextPage ? 1 : 0
        params["page"] = "\(searchPage)"
        params["query"] = searchText

        listService.fetchList(url: searchScope.url, entity: SearchListResponse.self, params: params, responseHandler: { (result) in
            let list: [ListModelData] = (result as! SearchListResponse).results.map( { ListModelData(result: $0) })
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}

struct ListModelConfig {
    var moviePages: [Int] = [1, 1, 1]
    var showPages: [Int] = [1, 1, 1]
    var searchPage: Int = 1
}
