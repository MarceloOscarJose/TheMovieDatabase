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
    let movieScopes = ConfigManager.shared.config.listScopes.movie.scopes!
    let showScopes = ConfigManager.shared.config.listScopes.show.scopes!

    func getMovieList(nextPage: Bool, scope: Int, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        listService.fetchList(url: movieScopes[scope].url, entity: MovieListResponse.self, page: 1, responseHandler: { (result) in
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
        listService.fetchList(url: showScopes[scope].url, entity: ShowListResponse.self, page: 1, responseHandler: { (result) in
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
