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

    // Page control
    var moviePage: Int = 1
    var showPage: Int = 1

    func getList(nextPage: Bool, section: ListCategory.section, type: ListCategory.type, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        moviePage += nextPage ? 1 : 0
        listService.fetchList(section: section, type: type, page: moviePage, responseHandler: { (result) in
            var list: [ListData] = []
            if section == .Movie {
                for element in (result as! MovieResult).results {
                    list.append(ListData(movie: element))
                }
            } else {
                for element in (result as! ShowResult).results {
                    list.append(ListData(show: element))
                }
            }
            responseHandler(list)
        }) { (error) in
            errorHandler(error)
        }
    }
}

struct ListModelData {
    
}
