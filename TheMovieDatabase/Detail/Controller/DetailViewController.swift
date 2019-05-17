//
//  DetailViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var id: Int!
    var delegate: DetailViewControllerDelegate!

    convenience init(id: Int, delegate: DetailViewControllerDelegate) {
        self.init()
        self.id = id
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getdetail()
    }

    func getdetail() {
        self.delegate.getDetail(id: id, responseHandler: { (detailData) in
            self.updateDetail(detailData: detailData)
        }) { (error) in
            print(error as Any)
        }
    }

    func updateDetail(detailData: DetailData) {
        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image)
        } else {
            posterImage.image = UIImage(named: "no-image")
        }

        titleLabel.text = detailData.title
        averageLabel.text = detailData.average
        dateLabel.text = detailData.releaseDate
        genresLabel.text = detailData.genres
        overviewLabel.text = detailData.overview
    }
}

protocol DetailViewControllerDelegate: class {
    func getDetail(id: Int, responseHandler: @escaping (_ response: DetailData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
