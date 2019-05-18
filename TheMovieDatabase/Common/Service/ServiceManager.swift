//
//  ServiceManager.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Alamofire

class GeneralService: NSObject {

    public func executeRequest(url: String, paramaters: [String: AnyObject], responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        var params = paramaters
        params["api_key"] = ConfigManager.shared.config.apiKey as AnyObject

        if let finalURL = URL(string: "\(ConfigManager.shared.config.baseURL)\(url)") {
            self.executeRequest(method: .get, url: finalURL, paramaters: params, responseHandler: responseHandler, errorHandler: errorHandler)
        }
    }

    private func executeRequest(method: Alamofire.HTTPMethod, url: URL, paramaters: [String: AnyObject]?, responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let request = Alamofire.request(url, method: method, parameters: paramaters, encoding: URLEncoding.default, headers: nil)

        request.response(completionHandler: { (response) in

            if let _ = response.error {
                errorHandler(response.error)
                return
            }

            if let responseValue = response.data {
                if response.response?.statusCode != 200 {
                    responseHandler(responseValue)
                    return
                }
                if response.error != nil {
                    errorHandler(response.error)
                } else {
                    responseHandler(responseValue)
                }

                return
            }

            errorHandler(nil)
        })
    }
}
