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
    var thumbnailURL = ""
    var imageURL = ""

    var listScopes: ConfigData!

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let data: NSDictionary = NSDictionary(contentsOfFile: path) {

                // General config
                self.baseURL = data["baseURL"] as! String
                self.apiKey = data["apiKey"] as! String
                self.thumbnailURL = data["thumbnailURL"] as! String
                self.imageURL = data["imageURL"] as! String

                // List scopes
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data["listScopes"] as! NSDictionary , options: .prettyPrinted)
                    self.listScopes = try JSONDecoder().decode(ConfigData.self, from: jsonData)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

struct ConfigData: Codable {
    var movie: ScopeSection
    var show: ScopeSection

    struct ScopeSection: Codable {
        var title: String
        var scopes: [ScopeData]

        struct ScopeData: Codable {
            var title: String
            var url: String
        }
    }
}
