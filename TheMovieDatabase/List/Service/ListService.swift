//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ListService: GeneralService {

    func fetchList<T: Codable>(url: String, entity: T.Type, page: Int, params: [String: String]?, responseHandler: @escaping (_ response: Codable) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        var parameters: [String: String] = params ?? [:]
        parameters["page"] = "\(page)"

        self.executeRequest(url: url, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in

            do {
                let listResult = try JSONDecoder().decode(entity, from: data)
                responseHandler(listResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
