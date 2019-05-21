//
//  String.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

extension String {

    func capitalizedFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }

    func parseToLongDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"

        guard let formattedDate = dateFormatter.date(from: self) else { return "" }
        return formatter.string(from: formattedDate).capitalizedFirstLetter()
    }
}
