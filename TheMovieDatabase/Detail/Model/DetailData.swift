//
//  DetailData.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 14/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

struct DetailData {
    var id: Int = 0
    var title: String = ""
    var average: String = ""
    var genres: String = ""
    var overview: String = ""
    var poster: String?
    var releaseDate: String = ""

    init(movieDetail: MovieDetailResponse) {
        self.init(id: movieDetail.id,
            title: movieDetail.title,
            image: movieDetail.posterPath,
            average: movieDetail.voteAverage,
            overview: movieDetail.overview,
            genres: movieDetail.genres.map({ $0.name }),
            date: movieDetail.releaseDate
        )
    }

    init(showDetail: ShowDetailResponse) {
        self.init(id: showDetail.id,
            title: showDetail.name,
            image: showDetail.posterPath,
            average: showDetail.voteAverage,
            overview: showDetail.overview,
            genres: showDetail.genres.map({ $0.name }),
            date: showDetail.firstAirDate
        )
    }

    init(id: Int, title: String, image: String?, average: Double, overview: String, genres: [String], date: String) {
        self.id = id
        self.title = title

        if let posterImage = image {
            self.poster = "\(ConfigManager.sharedInstance.imageURL)\(posterImage)"
        }

        self.average = average != 0 ? "⭐️ \(average)" : "N/R"
        self.overview = overview != "" ? overview : "No description"
        self.genres = genres.joined(separator: " / ")

        self.releaseDate = formatDate(date: date)
    }

    fileprivate func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatter = DateFormatter.longDate
        guard let formattedDate = dateFormatter.date(from: date) else { return "" }
        return formatter.string(from: formattedDate).capitalizedFirstLetter()
    }
}
