//
//  MovieListResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct MovieListResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    public struct Movie: Codable {
        var id: Int
        var voteAverage: Double
        var title: String
        var posterPath: String?
        var overview: String
        var releaseDate: String

        enum CodingKeys: String, CodingKey {
            case id, title, overview
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
        }
    }
}
