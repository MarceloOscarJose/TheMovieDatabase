//
//  CastCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 16/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        castImage.af_cancelImageRequest()
        castImage.image = UIImage(named: "no-image")
    }

    func updateCell(image: String?, name: String, character: String) {
        nameLabel.text = name.isEmpty ? "-" : name
        characterLabel.text = character.isEmpty ? "-" : character

        if let image = URL(string: "\(ConfigManager.sharedInstance.thumbnailURL)\(image ?? "")") {
            castImage.af_setImage(withURL: image)
        } else {
            castImage.image = UIImage(named: "no-image")
        }
    }
}
