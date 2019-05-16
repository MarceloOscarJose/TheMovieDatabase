//
//  DetailData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 14/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct DetailData {
    var id: Int
    var title: String
    var average: String
    var overview: String
    var poster: String?
    var backdrop: String?
    var releaseDate: String = ""

    init(movieDetail: MovieDetailResponse) {
        self.id = movieDetail.id
        self.title = movieDetail.title

        self.average = movieDetail.voteAverage != 0 ? "⭐️ \(movieDetail.voteAverage)" : "N/R"
        self.overview = movieDetail.overview != "" ? movieDetail.overview : "No description"

        if let posterImage = movieDetail.posterPath {
            self.poster = "\(ConfigManager.sharedInstance.imageURL)\(posterImage)"
        }
        if let backdropImage = movieDetail.backdropPath {
            self.backdrop = "\(ConfigManager.sharedInstance.imageURL)\(backdropImage)"
        }

        self.releaseDate = formatDate(date: movieDetail.releaseDate)
    }

    init(showDetail: ShowDetailResponse) {
        self.id = showDetail.id
        self.title = showDetail.name

        self.average = showDetail.voteAverage != 0 ? "⭐️ \(showDetail.voteAverage)" : "N/R"
        self.overview = showDetail.overview != "" ? showDetail.overview : "No description"

        if let posterImage = showDetail.posterPath {
            self.poster = "\(ConfigManager.sharedInstance.imageURL)\(posterImage)"
        }
        if let backdropImage = showDetail.backdropPath {
            self.backdrop = "\(ConfigManager.sharedInstance.imageURL)\(backdropImage)"
        }

        self.releaseDate = formatDate(date: showDetail.firstAirDate)
    }

    fileprivate func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatter = DateFormatter.longDate
        guard let formattedDate = dateFormatter.date(from: date) else { return "" }
        return formatter.string(from: formattedDate).capitalizedFirstLetter()
    }
}
