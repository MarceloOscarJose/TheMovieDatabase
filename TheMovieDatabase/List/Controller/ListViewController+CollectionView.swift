//
//  ListViewController+CollectionView.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 09/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

// MARK: CollectionView behaviour
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDataFilter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ListCollectionViewCell

        if self.listDataFilter.count > indexPath.item {
            let data = self.listDataFilter[indexPath.item]
            cell.updateCell(image: data.poster, title: data.title, overview: data.overview, date: data.releaseDate, average: data.average)

            if indexPath.item == self.listDataFilter.count - 1 {
                guard let query = self.searchBar.text else { return cell }
                if self.delegate.getListOnInit() {
                    if query.isEmpty {
                        self.getList(animated: false, nextPage: true)
                    }
                } else {
                    self.getList(animated: false, nextPage: true, query: query)
                }
            }
        }

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollTopButton.isHidden = scrollView.contentOffset.y > scrollView.frame.height ? false : true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width
        return CGSize(width: widthPerItem, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = self.listDataFilter[indexPath.item]

        if let navController = self.navigationController {
            if detail.mediaType == .Movie {
                navController.pushViewController(DetailViewController(id: detail.id, delegate: MovieDetailDelegate()), animated: true)
            } else {
                navController.pushViewController(DetailViewController(id: detail.id, delegate: ShowDetailDelegate()), animated: true)
            }
        }
    }
}
