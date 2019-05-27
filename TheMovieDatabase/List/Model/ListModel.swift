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

    var currentPages: [Int]!

    var params: [String: String] = ["page" : "1"]

    convenience init(scope: ConfigData.Scope) {
        self.init()
        self.currentScope = scope
        self.currentPages = Array(repeating: 1, count: scope.data.count)
    }

    func getList<T: Codable>(nextPage: Bool, query: String, scope: Int, entity: T.Type, responseHandler: @escaping (_ response: [ListModelData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        currentPages[scope] = nextPage ? currentPages[scope] + 1 : 1
        params["page"] = "\(currentPages[scope])"
        params["query"] = query

        listService.fetchList(url: currentScope.data[scope].url, entity: entity, params: params, responseHandler: { (result) in

            switch self.currentScope.id {
            case "movies":
                responseHandler((result as! MovieListResponse).results.map( { ListModelData(movie: $0) }))
            case "shows":
                responseHandler((result as! ShowListResponse).results.map( { ListModelData(show: $0) }))
            case "search":
                responseHandler((result as! SearchListResponse).results.map( { ListModelData(result: $0) }))
            default:
                break
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
