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
    var video: [DetailResponse.VideoResults.Video] = []

    init(movieDetail: MovieDetailResponse) {
        self.init(id: movieDetail.id,
            title: movieDetail.title,
            image: movieDetail.posterPath,
            average: movieDetail.voteAverage,
            overview: movieDetail.overview,
            genres: movieDetail.genres.map({ $0.name }),
            date: movieDetail.releaseDate,
            cast: movieDetail.credits.cast,
            video: movieDetail.videos.results
        )
    }

    init(showDetail: ShowDetailResponse) {
        self.init(id: showDetail.id,
            title: showDetail.name,
            image: showDetail.posterPath,
            average: showDetail.voteAverage,
            overview: showDetail.overview,
            genres: showDetail.genres.map({ $0.name }),
            date: showDetail.firstAirDate ?? "",
            cast: showDetail.credits.cast,
            video: showDetail.videos.results
        )
    }

    init(id: Int, title: String, image: String?, average: Double, overview: String, genres: [String], date: String, cast: [DetailResponse.Credits.Cast], video: [DetailResponse.VideoResults.Video]) {
        self.id = id
        self.title = title

        if let posterImage = image {
            self.poster = "\(ConfigManager.shared.config.imageURL)\(posterImage)"
        }

        self.average = !average.isZero ? "\(average)" : "-"
        self.releaseDate = "Date: \(date.parseToLongDate())"
        self.genres = genres.isEmpty ? "No genres" : genres.joined(separator: " / ")

        self.overview = !overview.isEmpty ? overview : "No description"
        self.cast = cast.sorted(by: { $1.order > $0.order })
        self.video = video
    }
}
