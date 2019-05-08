//
//  ConfigManager.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ConfigManager: NSObject {

    static let sharedInstance = ConfigManager()

    // Config vars
    var baseURL = ""
    var apiKey = ""
    var imagesURL = ""

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let nsDictionary: NSDictionary = NSDictionary(contentsOfFile: path) {
                self.baseURL = nsDictionary["BaseURL"] as! String
                self.apiKey = nsDictionary["ApiKey"] as! String
                self.imagesURL = nsDictionary["ImagesURL"] as! String
            }
        }
    }
}
