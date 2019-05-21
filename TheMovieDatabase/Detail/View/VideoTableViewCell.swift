//
//  VideoTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        videoImage.af_cancelImageRequest()
        videoImage.image = UIImage.noImage
    }

    func updateCell(image: String, title: String) {
        videoLabel.text = title

        if let imageURL = URL(string: "\(ConfigManager.shared.config.videoURL.replace(target: "[id]", withString: image))") {
            videoImage.af_setImage(withURL: imageURL, placeholderImage: UIImage.noImage, imageTransition: .crossDissolve(0.5))
        }
    }
}
