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
    var videoURL: String
    var scopes: [Scope]

    struct Scope: Codable {
        var id: String
        var title: String
        var data: [ScopeData]
    }

    struct ScopeData: Codable {
        var id: String
        var title: String
        var url: String
    }

    func getSectionScope(section: String) -> Scope {
        return self.scopes.filter({ $0.id ==  section}).first!
    }
}
