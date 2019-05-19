//
//  ConfigManager.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ConfigManager: NSObject {

    static let shared = ConfigManager()

    // Config vars
    var config: ConfigData!

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let data: NSDictionary = NSDictionary(contentsOfFile: path) {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data as NSDictionary , options: .prettyPrinted)
                    self.config = try JSONDecoder().decode(ConfigData.self, from: jsonData)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

struct ConfigData: Codable {

    var baseURL: String
    var apiKey: String
    var thumbnailURL: String
    var imageURL: String
    var listScopes: ListScopes

    struct ListScopes: Codable {
        var movie: ScopeSection
        var show: ScopeSection
        var search: ScopeSection

        struct ScopeSection: Codable {
            var title: String
            var icon: String
            var scopes: [ScopeData]

            struct ScopeData: Codable {
                var title: String
                var url: String
            }
        }
    }
}
