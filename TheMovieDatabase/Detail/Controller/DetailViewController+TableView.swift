//
//  DetailViewController+TableView.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

// MARK: Table view delegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.video.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: videoCellIdentifier, for: indexPath) as! VideoTableViewCell
        cell.updateCell(image: video[indexPath.item].key, title: video[indexPath.item].name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoController = DetailVideoViewController()
        videoController.setVideoId(videoId: video[indexPath.item].key)
        self.navigationController?.pushViewController(videoController, animated: true)
    }
}
