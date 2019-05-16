//
//  MovieViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

/*class MovieViewController: BaseViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    let model = DetailModel()
    var id: Int!
    //var section: ListCategory.section!

    /*convenience init(id: Int, section: ListCategory.section) {
        self.init()
        self.id = id
        self.section = section
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDetail(id: id, section: section)
    }

    func getDetail(id: Int, section: ListCategory.section) {
        model.getDetail(id: id, section: section, responseHandler: { (detailData) in
            self.updateDetail(detailData: detailData)
        }) { (error) in
            self.showSnakError(title: "Error connecting to service", buttonText: "Retry", completion: {
                self.getDetail(id: id, section: section)
            })
        }
    }

    func updateDetail(detailData: DetailData) {
        titleLabel.text = detailData.title

        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image)
        } else {
            posterImage.image = UIImage(named: "no-image")
        }
    }*/
}
*/
