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

    func getMovieList(nextPage: Bool, url: String, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        listService.fetchList(url: url, entity: MovieListResponse.self, page: 1, responseHandler: { (result) in
            var list: [ListData] = []
            for element in (result as! MovieListResponse).results {
                list.append(ListData(movie: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShowList(nextPage: Bool, url: String, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        listService.fetchList(url: url, entity: ShowListResponse.self, page: 1, responseHandler: { (result) in
            var list: [ListData] = []
            for element in (result as! ShowListResponse).results {
                list.append(ListData(show: element))
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}
