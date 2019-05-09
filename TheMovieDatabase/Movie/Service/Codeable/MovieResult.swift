//
//  MovieResult.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 08/05/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct MovieResult: Codable {

    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey
    {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

public struct Movie: Codable {

    var id: Int
    var voteCount: Int
    var video: Bool
    var voteAverage: Double
    var title: String
    var popularity: Double
    var genreIds: [Int]
    var posterPath: String?
    var originalLanguage: String
    var originalTitle: String
    var backdropPath: String?
    var overview: String
    var releaseDate: String

    enum CodingKeys: String, CodingKey
    {
        case id
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
}
