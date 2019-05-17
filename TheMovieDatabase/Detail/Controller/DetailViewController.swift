//
//  DetailViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!

    // UI Details
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    // UI Cast
    @IBOutlet weak var castCollectionView: UICollectionView!

    var id: Int!
    var delegate: DetailViewControllerDelegate!

    // Data car
    let castCellIdentifier = "CastCollectionViewCell"
    var cast: [DetailResponse.Credits.Cast] = []

    convenience init(id: Int, delegate: DetailViewControllerDelegate) {
        self.init()
        self.id = id
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        getdetail()
    }

    func getdetail() {
        self.delegate.getDetail(id: id, responseHandler: { (detailData) in
            self.updateDetail(detailData: detailData)
            self.updateCast(cast: detailData.cast)
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

    func updateCast(cast: [DetailResponse.Credits.Cast]) {
        self.cast = cast
        castCollectionView.register(UINib(nibName: castCellIdentifier, bundle: .main), forCellWithReuseIdentifier: castCellIdentifier)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.alpha = 0
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        detailView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        castCollectionView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0

        castCollectionView.reloadData()
        self.view.layoutIfNeeded()
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellIdentifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width
        return CGSize(width: widthPerItem, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}

protocol DetailViewControllerDelegate: class {
    func getDetail(id: Int, responseHandler: @escaping (_ response: DetailData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
