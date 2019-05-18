//
//  DetailModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailModel: NSObject {

    let service = DetailService()

    func getMovieDetail(id: Int, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        service.fetchDetail(url: "movie/\(id)", entity: MovieDetailResponse.self, responseHandler: { (result) in
            responseHandler(DetailModelData(movieDetail: result as! MovieDetailResponse))
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShowDetail(id: Int, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        service.fetchDetail(url: "tv/\(id)", entity: ShowDetailResponse.self, responseHandler: { (result) in
            responseHandler(DetailModelData(showDetail: result as! ShowDetailResponse))
        }) { (error) in
            errorHandler(error)
        }
    }
}
