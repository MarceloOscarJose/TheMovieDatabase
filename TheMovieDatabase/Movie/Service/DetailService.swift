//
//  DetailService.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailService: GeneralService {

    func fetchDetail(id: Int, section: ListCategory.section, responseHandler: @escaping (_ response: Codable) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        self.executeRequest(url: "movie/\(id)", paramaters: [:], responseHandler: { (data) in

            do {
                var listResult: Codable

                if section == .Movie {
                    listResult = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
                } else {
                    listResult = try JSONDecoder().decode(ShowDetailResponse.self, from: data)
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
