//
//  MovieDetailResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct ShowDetailResponse: Codable {
    var id: Int
    var name: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var firstAirDate: String
    var voteAverage: Double
    var genres: [Genres]
    var videos: DetailResponse.VideoResults
    var credits: DetailResponse.Credits
    var seasons: [Seasons]

    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres, videos, credits, seasons
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
    }

    public struct Genres: Codable {
        var name: String
    }

    public struct Seasons: Codable {
        var airDate: String
        var episodeCount: Int
        var name: String
        var overview: String

        enum CodingKeys: String, CodingKey
        {
            case name, overview
            case episodeCount = "episode_count"
            case airDate = "air_date"
        }
    }
}
