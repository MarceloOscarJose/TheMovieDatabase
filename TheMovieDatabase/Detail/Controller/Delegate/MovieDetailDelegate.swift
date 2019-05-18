//
//  MovieDetailDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MovieDetailDelegate: DetailViewControllerDelegate {

    let model = DetailModel()

    func getDetail(id: Int, responseHandler: @escaping (DetailModelData) -> Void, errorHandler: @escaping (Error?) -> Void) {
        model.getMovieDetail(id: id, responseHandler: { (response) in
            responseHandler(response)
        }) { (error) in
            errorHandler(error)
        }
    }
}
