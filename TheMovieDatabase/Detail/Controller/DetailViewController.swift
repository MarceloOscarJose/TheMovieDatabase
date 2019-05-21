//
//  DetailViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class DetailViewController: BaseViewController {

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

    // UI Videos
    @IBOutlet weak var videoTableView: UITableView!
    
    var id: Int!
    var delegate: DetailViewDelegate!

    // Data vars
    let castCellIdentifier = "CastCollectionViewCell"
    let videoCellIdentifier = "VideoTableViewCell"
    var imageFrame: CGRect = .zero
    var imagePlaceHolder = UIImage.noImage
    var rightButtonTexts: [String] = ["Show poster", "Hide poster"]

    // Detail vars
    var cast: [DetailResponse.Credits.Cast] = []
    var video: [DetailResponse.VideoResults.Video] = []

    convenience init(id: Int, delegate: DetailViewDelegate) {
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

        hideControls()
        getdetail()
    }

    func getdetail() {
        toggleActivityIndicator(show: true)
        self.delegate.getDetail(id: id, responseHandler: { (detailData) in
            self.toggleActivityIndicator(show: false)
            self.showControls()
            self.updateDetail(detailData: detailData)
            self.updateCast(cast: detailData.cast)
        }) { (error) in
            self.toggleActivityIndicator(show: false)
            self.showSnackError(title: "Error connecting to service", buttonText: "Retry", view: self.scrollView, completion: {
                self.getdetail()
            })
        }
    }

    func updateDetail(detailData: DetailModelData) {
        self.posterImage.contentMode = .scaleAspectFit

        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image, placeholderImage: UIImage.noImage, imageTransition: .crossDissolve(0.5)) { (result) in
                self.posterImage.contentMode = .scaleAspectFill
            }
        } else {
            posterImage.image = UIImage.noImage
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

    func updateVideo(video: [DetailResponse.VideoResults.Video]) {
        self.video = video
        castCollectionView.register(UINib(nibName: videoCellIdentifier, bundle: .main), forCellWithReuseIdentifier: videoCellIdentifier)
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }

    func hideControls() {
        posterImage.alpha = 0
        detailView.alpha = 0
        castCollectionView.alpha = 0
        optionMenu.alpha = 0
        scrollView.isScrollEnabled = false
    }

    func showControls() {
        posterImage.alpha = 1
        posterImage.frame = self.imageFrame
        posterImage.contentMode = .scaleAspectFill
        optionMenu.alpha = 1
        selectOption(optionMenu)
        scrollView.isScrollEnabled = true
    }

    func showFullPoster() {
        posterImage.alpha = 1
        posterImage.frame = self.scrollView.bounds
        posterImage.contentMode = .scaleAspectFill
    }

    @objc func showFullScreenPoster(_ sender: Any) {
        if self.posterImage.image != imagePlaceHolder {
            if detailView.alpha != 0 || castCollectionView.alpha != 0 {
                hideControls()
                showFullPoster()
                self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.last!
            } else {
                showControls()
                self.navigationItem.rightBarButtonItem?.title = self.rightButtonTexts.first!
            }
        }
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        detailView.alpha = sender.selectedSegmentIndex == 0 ? 1 : 0
        castCollectionView.alpha = sender.selectedSegmentIndex == 1 ? 1 : 0
        videoTableView.alpha = sender.selectedSegmentIndex == 2 ? 1 : 0
        self.view.layoutSubviews()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}

protocol DetailViewDelegate: class {
    func getDetail(id: Int, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
