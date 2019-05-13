//
//  DetailService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailService: GeneralService {

    func fetchDetail(id: Int, responseHandler: @escaping (_ response: MovieResponse) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.executeRequest(url: "movie/\(id)", paramaters: [:], responseHandler: { (data) in

            do {
                let listResult = try JSONDecoder().decode(MovieResponse.self, from: data)
                responseHandler(listResult)
            } catch let error {
                errorHandler(error)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
