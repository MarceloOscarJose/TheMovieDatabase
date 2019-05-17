//
//  DetailResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct DetailResponse {

    public struct Credits: Codable {
        var cast: [Cast]

        public struct Cast: Codable {
            var name: String
            var character: String
            var profilePath: String?
            var order: Int

            enum CodingKeys: String, CodingKey {
                case name, character, order
                case profilePath = "profile_path"
            }
        }
    }

    public struct VideoResults: Codable {
        var results: [Video]

        struct Video: Codable {
            var key: String
            var name: String
        }
    }
}
