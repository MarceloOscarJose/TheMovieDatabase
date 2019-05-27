//
//  VideoViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 26/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoViewController: UIViewController {

    @IBOutlet weak var videoPlayerContainer: WKYTPlayerView!

    var videoId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayerContainer.load(withVideoId: videoId)
    }

    func setVideoId(videoId: String) {
        self.videoId = videoId
    }
}
