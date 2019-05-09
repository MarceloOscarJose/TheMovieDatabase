//
//  MovieData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct MovieData {

    var id: Int
    var title: String
    var average: String
    var popularity: Double
    var overview: String
    var poster: String?
    var releaseDate: String = ""

    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.average = movie.voteAverage != 0 ? "⭐️ \(movie.voteAverage)" : "N/R"
        self.overview = movie.overview != "" ? movie.overview : "No description"
        self.popularity = movie.popularity

        if let posterImage = movie.posterPath {
            self.poster = "\(ConfigManager.sharedInstance.imagesURL)\(posterImage)"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatter = DateFormatter.longDate
        guard let releaseDate = dateFormatter.date(from: movie.releaseDate) else { return }
        self.releaseDate = formatter.string(from: releaseDate).capitalizedFirstLetter()
    }
}
