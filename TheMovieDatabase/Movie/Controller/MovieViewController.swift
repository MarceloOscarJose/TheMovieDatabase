//
//  MovieViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class MovieViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var detailData: ListData!

    convenience init(detailData: ListData) {
        self.init()
        self.detailData = detailData
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = detailData.title

        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image)
        } else {
            posterImage.image = UIImage(named: "no-image")
        }
    }
}
