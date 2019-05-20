//
//  ListModelData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ListModelData {

    var id: Int
    var title: String
    var average: String
    var overview: String
    var poster: String?
    var releaseDate: String = ""
    var mediaType: MediaType!

    init(movie: MovieListResponse.Movie) {
        self.init(id: movie.id,
          title: movie.title,
          image: movie.posterPath,
          average: movie.voteAverage,
          overview: movie.overview,
          date: movie.releaseDate
        )

        self.mediaType = .Movie
    }

    init(show: ShowListResponse.Show) {
        self.init(id: show.id,
          title: show.name,
          image: show.posterPath,
          average: show.voteAverage,
          overview: show.overview,
          date: show.firstAirDate
        )

        self.mediaType = .Show
    }

    init(result: SearchListResponse.Result) {

        self.init(id: result.id,
              title: result.name ?? result.title ?? "",
              image: result.posterPath,
              average: result.voteAverage,
              overview: result.overview,
              date: result.firstAirDate ?? result.releaseDate ?? ""
        )

        self.mediaType = result.mediaType == "movie" ? .Movie : .Show
    }

    init(id: Int, title: String, image: String?, average: Double, overview: String, date: String) {
        self.id = id
        self.title = title

        if let posterImage = image {
            self.poster = "\(ConfigManager.shared.config.thumbnailURL)\(posterImage)"
        }

        self.average = average != 0 ? "⭐️ \(average)" : "N/R"
        self.overview = overview != "" ? overview : "No description"
        self.releaseDate = date.parseToLongDate()
    }
}

enum MediaType {
    case Movie
    case Show
}
