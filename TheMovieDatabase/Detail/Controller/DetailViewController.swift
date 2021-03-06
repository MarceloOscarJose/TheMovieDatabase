//
//  DetailViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 12/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import AlamofireImage

class DetailViewController: BaseViewController {

    // UI Main controls
    var rightButton: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var optionMenu: UISegmentedControl!

    // UI Details
    @IBOutlet weak var detailContainer: UIView!
    @IBOutlet weak var detailView: UIScrollView!
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
    var rightButtonTexts: [String] = ["Show poster", "Hide poster"]
    let castCellIdentifier = "CastCollectionViewCell"
    let videoCellIdentifier = "VideoTableViewCell"

    var imageFrame: CGRect = .zero
    var imagePlaceHolder = UIImage.noImage

    // Detail vars
    var cast: [DetailResponse.Credits.Cast] = []
    var video: [DetailResponse.VideoResults.Video] = []

    convenience init(id: Int, delegate: DetailViewDelegate) {
        self.init()
        self.id = id
        self.delegate = delegate
        self.rightButton = UIBarButtonItem(title: rightButtonTexts.first!, style: .plain, target: self, action: #selector(showFullPoster))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        getdetail()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageFrame = posterImage.frame
    }

    func setupControls() {
        titleLabel.adjustsFontSizeToFitWidth = true
        toogleControls(show: false)
    }

    func getdetail() {
        toggleActivityIndicator(show: true)

        self.delegate.getDetail(id: id, responseHandler: { (detailData) in
            self.toogleControls(show: true)
            self.updateDetail(detailData: detailData)
            self.updateCast(cast: detailData.cast)
            self.updateVideo(video: detailData.video)
            self.toggleActivityIndicator(show: false)
        }) { (error) in
            self.toggleActivityIndicator(show: false)
            self.showSnackError(title: "Error connecting to service", buttonText: "Retry", view: self.containerView, completion: {
                self.getdetail()
            })
        }
    }

    func updateDetail(detailData: DetailModelData) {
        if let image = URL(string: detailData.poster ?? "") {
            posterImage.af_setImage(withURL: image, placeholderImage: UIImage.noImage, imageTransition: .crossDissolve(0.5)) { (result) in
                self.posterImage.contentMode = .scaleAspectFill
                self.navigationItem.rightBarButtonItem = self.rightButton
            }
        } else {
            posterImage.image = UIImage.noImage
            posterImage.contentMode = .scaleAspectFit
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
        videoTableView.register(UINib(nibName: videoCellIdentifier, bundle: .main), forCellReuseIdentifier: videoCellIdentifier)
        videoTableView.rowHeight = 100
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }

    func toogleControls(show: Bool) {
        containerView.isHidden = !show
        selectOption(optionMenu)
    }

    @objc func showFullPoster() {
        let fullScreen = !detailContainer.isHidden
        detailContainer.isHidden = fullScreen
        posterImage.frame = fullScreen ? containerView.bounds : imageFrame
        navigationItem.rightBarButtonItem?.title = fullScreen ? rightButtonTexts.last! : rightButtonTexts.first!
    }

    @IBAction func selectOption(_ sender: UISegmentedControl) {
        detailView.isHidden = sender.selectedSegmentIndex == 0 ? false : true
        castCollectionView.isHidden = sender.selectedSegmentIndex == 1 ? false : true
        videoTableView.isHidden = sender.selectedSegmentIndex == 2 ? false : true
    }
}

protocol DetailViewDelegate: class {
    func getDetail(id: Int, responseHandler: @escaping (_ response: DetailModelData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
