//
//  MovieDetailResponse.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 13/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct MovieDetailResponse: Codable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String
    var voteAverage: Double
    var genres: [Genres]
    var videos: VideoResults
    var credits: Credits

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, videos, credits
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    public struct Genres: Codable {
        var name: String
    }

    public struct Credits: Codable {
        var cast: [Cast]

        public struct Cast: Codable {
            var name: String
            var character: String
            var profilePath: String?

            enum CodingKeys: String, CodingKey {
                case name, character
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
