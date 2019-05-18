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

    func getMovieDetail(url: String, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        service.fetchDetail(url: url, entity: MovieDetailResponse.self, responseHandler: { (result) in
            responseHandler(DetailModelData(movieDetail: result as! MovieDetailResponse))
        }) { (error) in
            errorHandler(error)
        }
    }

    func getShowDetail(url: String, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        service.fetchDetail(url: url, entity: ShowDetailResponse.self, responseHandler: { (result) in
            responseHandler(DetailModelData(showDetail: result as! ShowDetailResponse))
        }) { (error) in
            errorHandler(error)
        }
    }
}
