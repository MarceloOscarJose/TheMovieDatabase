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
    var currentScope: ConfigData.Scope!
    var currentPages: [ListModelPages] = []

    var params: [String: String] = ["page" : "1"]

    convenience init(scope: ConfigData.Scope) {
        self.init()
        self.currentScope = scope
        self.currentPages = scope.data.map { _ in ListModelPages(currentPage: 1, maxPages: 1) }
    }

    func getList<T: Codable>(nextPage: Bool, query: String, scope: Int, entity: T.Type, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        currentPages[scope].currentPage = nextPage ? currentPages[scope].currentPage + 1 : 1
        params["page"] = "\(currentPages[scope])"
        params["query"] = query

        listService.fetchList(url: currentScope.data[scope].url, entity: entity, params: params, responseHandler: { (result) in

            var responseList: [ListModelData] = []
            var totalPages: Int = 1

            switch self.currentScope.id {
            case "movies":
                let responseData = (result as! MovieListResponse)
                totalPages = responseData.totalPages
                responseList = responseData.results.map( { ListModelData(movie: $0) })
            case "shows":
                let responseData = (result as! ShowListResponse)
                totalPages = responseData.totalPages
                responseList = responseData.results.map( { ListModelData(show: $0) })
            case "search":
                let responseData = (result as! SearchListResponse)
                totalPages = responseData.totalPages
                responseList = responseData.results.map( { ListModelData(result: $0) })
            default:
                break
            }

            self.currentPages[scope].maxPages = totalPages
            responseHandler(responseList)
        }) { (error) in
            errorHandler(error)
        }
    }
}

struct ListModelPages {
    var currentPage: Int
    var maxPages: Int
}
