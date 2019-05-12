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

    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title

        self.average = movie.voteAverage != 0 ? "⭐️ \(movie.voteAverage)" : "N/R"
        self.overview = movie.overview != "" ? movie.overview : "No description"

        if let posterImage = movie.posterPath {
            self.poster = "\(ConfigManager.sharedInstance.thumbnailURL)\(posterImage)"
        }

        self.releaseDate = formatDate(date: movie.releaseDate)
    }

    init(show: Show) {
        self.id = show.id
        self.title = show.name

        self.average = show.voteAverage != 0 ? "⭐️ \(show.voteAverage)" : "N/R"
        self.overview = show.overview != "" ? show.overview : "No description"

        if let posterImage = show.posterPath {
            self.poster = "\(ConfigManager.sharedInstance.thumbnailURL)\(posterImage)"
        }

        self.releaseDate = formatDate(date: show.firstAirDate)
    }

    fileprivate func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatter = DateFormatter.longDate
        guard let formattedDate = dateFormatter.date(from: date) else { return "" }
        return formatter.string(from: formattedDate).capitalizedFirstLetter()
    }
}
