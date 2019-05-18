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
    @IBOutlet weak var optionMenu: UISegmentedControl!
    
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

    // Data vars
    let castCellIdentifier = "CastCollectionViewCell"
    var imageFrame: CGRect = .zero
    var imagePlaceHolder = UIImage(named: "no-image")
    var rightButtonTexts: [String] = ["Show poster", "Hide poster"]
    var cast: [DetailResponse.Credits.Cast] = []

    convenience init(id: Int, delegate: DetailViewControllerDelegate) {
        self.init()
        self.id = id
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageFrame = self.posterImage.frame
    }

    func setupControls() {
        scrollView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonTexts.first!, style: .plain, target: self, action: #selector(showFullScreenPoster))

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

    func updateDetail(detailData: DetailModelData) {
        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image, imageTransition: .crossDissolve(0.5))
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
    }

    func hideControls() {
        posterImage.frame = self.scrollView.bounds
        posterImage.contentMode = .scaleAspectFill
        detailView.alpha = 0
        castCollectionView.alpha = 0
        optionMenu.alpha = 0
        scrollView.isScrollEnabled = false
        self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.last!
    }

    func resetControls() {
        posterImage.frame = self.imageFrame
        posterImage.contentMode = .scaleAspectFill
        optionMenu.alpha = 1
        selectOption(optionMenu)
        scrollView.isScrollEnabled = true
        self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.first!
    }

    @objc func showFullScreenPoster(_ sender: Any) {
        if self.posterImage.image != imagePlaceHolder {
            if detailView.alpha != 0 || castCollectionView.alpha != 0 {
                hideControls()
            } else {
                resetControls()
            }
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        detailView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        castCollectionView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
        self.view.layoutSubviews()
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellIdentifier, for: indexPath) as! CastCollectionViewCell
        let castData = cast[indexPath.item]
        cell.updateCell(image: castData.profilePath, name: castData.name, character: castData.character)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
    func getDetail(id: Int, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
