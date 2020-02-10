//
//  MainViewController.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/5.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    fileprivate lazy var mainViewModel = MainViewModel()
    fileprivate let photoIdentifier = "PhotoCell"
    fileprivate let videoIdentifier = "VideoCell"
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.photoCollectionView.collectionViewLayout as! MiniGalleryFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        mainViewModel.fetchGalleryData {
            DispatchQueue.main.async {
                self.videoCollectionView.reloadData()
                self.photoCollectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
        videoCollectionView.register(UINib(nibName: videoIdentifier, bundle: nil),
                                             forCellWithReuseIdentifier: videoIdentifier)
        photoCollectionView.register(UINib(nibName: photoIdentifier, bundle: nil),
                                             forCellWithReuseIdentifier: photoIdentifier)
        videoCollectionView.collectionViewLayout = mainViewModel.setupColletionViewLayout(.video)
        photoCollectionView.collectionViewLayout = mainViewModel.setupColletionViewLayout(.photo)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.miniGalleryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case videoCollectionView:
            let cell: VideoCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: videoIdentifier,
                                                                                       for: indexPath) as! VideoCell
            cell.videoModel = mainViewModel.miniGalleryModel[indexPath.item]
            return cell
        case photoCollectionView:
            let cell: PhotoCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: photoIdentifier,
                                                                           for: indexPath) as! PhotoCell
            cell.photoModel = mainViewModel.miniGalleryModel[indexPath.item]
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == videoCollectionView {
            let offset = videoCollectionView.contentOffset.x
            currentPage = offset > 0 ? Int(floor(offset / scrollView.frame.width) + 1) : Int(floor(offset / scrollView.frame.width))
            photoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0),
                                           animated: true,
                                           scrollPosition: .centeredHorizontally)
        } else if scrollView == photoCollectionView {
            let pageSide = self.pageSize.width
            let offset = scrollView.contentOffset.x
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
            videoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0),
                                           animated: true,
                                           scrollPosition: .centeredHorizontally)
        }
    }
}


