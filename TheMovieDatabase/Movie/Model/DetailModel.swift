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

    func getDetail(id: Int, section: ListCategory.section, responseHandler: @escaping (_ response: [ListData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        service.fetchDetail(id: id, section: section, responseHandler: { (result) in
            if section == .Movie {
                //list.append(ListData(movie: element))
            } else {
                //list.append(ListData(show: element))
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
