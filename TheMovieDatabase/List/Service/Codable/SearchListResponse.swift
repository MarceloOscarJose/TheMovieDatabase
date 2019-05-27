//
//  SearchListResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 19/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct SearchListResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    public struct Result: Codable {
        var id: Int
        var voteAverage: Double?
        var name: String?
        var title: String?
        var posterPath: String?
        var overview: String?
        var releaseDate: String?
        var firstAirDate: String?
        var mediaType: String

        enum CodingKeys: String, CodingKey {
            case id, name, title, overview
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
            case firstAirDate = "first_air_date"
            case releaseDate = "release_date"
            case mediaType = "media_type"
        }
    }
}
