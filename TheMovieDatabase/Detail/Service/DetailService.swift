//
//  DetailService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class DetailService: GeneralService {

    let paramaters = ["append_to_response": "videos,credits"]

    func fetchDetail<T: Codable>(url: String, entity: T.Type, responseHandler: @escaping (_ response: Codable) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.executeRequest(url: url, paramaters: paramaters as [String : AnyObject], responseHandler: { (data) in
            do {
                let detailResult = try JSONDecoder().decode(entity, from: data)
                responseHandler(detailResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
