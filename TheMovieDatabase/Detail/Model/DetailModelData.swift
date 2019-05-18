//
//  DetailModelData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 14/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct DetailModelData {
    var id: Int = 0
    var title: String = ""
    var average: String = ""
    var genres: String = ""
    var overview: String = ""
    var poster: String?
    var releaseDate: String = ""
    var cast: [DetailResponse.Credits.Cast] = []

    init(movieDetail: MovieDetailResponse) {
        self.init(id: movieDetail.id,
            title: movieDetail.title,
            image: movieDetail.posterPath,
            average: movieDetail.voteAverage,
            overview: movieDetail.overview,
            genres: movieDetail.genres.map({ $0.name }),
            date: movieDetail.releaseDate,
            cast: movieDetail.credits.cast
        )
    }

    init(showDetail: ShowDetailResponse) {
        self.init(id: showDetail.id,
            title: showDetail.name,
            image: showDetail.posterPath,
            average: showDetail.voteAverage,
            overview: showDetail.overview,
            genres: showDetail.genres.map({ $0.name }),
            date: showDetail.firstAirDate,
            cast: showDetail.credits.cast
        )
    }

    init(id: Int, title: String, image: String?, average: Double, overview: String, genres: [String], date: String, cast: [DetailResponse.Credits.Cast]) {
        self.id = id
        self.title = title

        if let posterImage = image {
            self.poster = "\(ConfigManager.sharedInstance.imageURL)\(posterImage)"
        }

        self.average = "Average: \(average != 0 ? "⭐️\(average)" : "N/R")"
        self.genres = "Genres: \(genres.joined(separator: " / "))"
        self.releaseDate = "Date: \(date.parseToLongDate())"

        self.overview = overview != "" ? overview : "No description"
        self.cast = cast.sorted(by: { $1.order > $0.order })
    }
}