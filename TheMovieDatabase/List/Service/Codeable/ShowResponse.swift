//
//  ShowResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct ShowResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Show]

    enum CodingKeys: String, CodingKey
    {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    public struct Show: Codable {
        var id: Int
        var voteAverage: Double
        var name: String
        var genreIds: [Int]
        var posterPath: String?
        var overview: String
        var firstAirDate: String

        enum CodingKeys: String, CodingKey
        {
            case id
            case voteAverage = "vote_average"
            case name
            case genreIds = "genre_ids"
            case posterPath = "poster_path"
            case overview
            case firstAirDate = "first_air_date"
        }
    }
}
