//
//  MovieCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import AlamofireImage

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Border
        containerView.layer.borderColor = UIColor.shadowColor.cgColor
        containerView.layer.borderWidth = 1
        separatorView.backgroundColor = UIColor.shadowColor

        // Shadow
        containerView.layer.shadowColor = UIColor.shadowColor.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOffset = CGSize(width: 5, height: 3)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = UIImage(named: "no-image")
    }

    func updateCell(image: String?, title: String, overview: String, date: String, average: String) {
        titleLabel.text = title
        overviewLabel.text = overview
        dateLabel.text = date
        averageLabel.text = average

        if let image = URL(string: image ?? "") {
            movieImage.af_setImage(withURL: image, imageTransition: .crossDissolve(0.5))
        } else {
            movieImage.image = UIImage(named: "no-image")
        }
    }
}
