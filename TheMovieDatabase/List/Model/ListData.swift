//
//  MovieData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ListData {

    var id: Int
    var title: String
    var average: String
    var overview: String
    var poster: String?
    var releaseDate: String = ""

    init(movie: MovieListResponse.Movie) {
        self.init(id: movie.id,
          title: movie.title,
          image: movie.posterPath,
          average: movie.voteAverage,
          overview: movie.overview,
          date: movie.releaseDate
        )
    }

    init(show: ShowListResponse.Show) {
        self.init(id: show.id,
          title: show.name,
          image: show.posterPath,
          average: show.voteAverage,
          overview: show.overview,
          date: show.firstAirDate
        )
    }

    init(id: Int, title: String, image: String?, average: Double, overview: String, date: String) {
        self.id = id
        self.title = title

        if let posterImage = image {
            self.poster = "\(ConfigManager.sharedInstance.thumbnailURL)\(posterImage)"
        }

        self.average = average != 0 ? "⭐️ \(average)" : "N/R"
        self.overview = overview != "" ? overview : "No description"
        self.releaseDate = date.parseToLongDate()
    }
}
