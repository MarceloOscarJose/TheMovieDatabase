//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ListService: GeneralService {

    func fetchList(section: ListCategory.section, type: ListCategory.type, page: Int, responseHandler: @escaping (_ response: Codable) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let parameters: [String: String] = ["page": "\(page)"]

        self.executeRequest(url: section.rawValue + type.rawValue, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in

            do {
                var listResult: Codable

                if section == .Movie {
                    listResult = try JSONDecoder().decode(MovieListResponse.self, from: data)
                } else {
                    listResult = try JSONDecoder().decode(ShowListResponse.self, from: data)
                }

                responseHandler(listResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}

enum ListCategory {

    enum section: String {
        case Movie = "movie/"
        case Show = "tv/"
    }

    enum type: String {
        case Popular = "popular"
        case TopRated = "top_rated"
        case Upcoming = "upcoming"
        case Onair = "on_the_air"
    }
}
