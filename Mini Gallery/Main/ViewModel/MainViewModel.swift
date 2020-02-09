//
//  MainViewModel.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/8.
//  Copyright © 2020 Allen. All rights reserved.
//

import Foundation
import UIKit

enum CollectionViewType: String {
    case video
    case photo
}

class MainViewModel:NSObject {
    
    lazy var photoCollectionView = UICollectionView()
    lazy var videoCollectionView = UICollectionView()

    fileprivate lazy var photoVM = CellViewModel()
    fileprivate let photoIdentifier = "PhotoCell"
    fileprivate let videoIdentifier = "VideoCell"
    fileprivate var currentPage: Int = 0

    fileprivate var pageSize: CGSize {
        let layout = self.photoCollectionView.collectionViewLayout as! MiniGalleryFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    public func setupCollectionView(_ type: CollectionViewType) {
        if type == .video {
            setupVideoFlowLayout()
        } else if type == .photo {
            setupPhotoFlowLayout()
        }
        fetchMiniGalleryData()
    }
    
    fileprivate func setupVideoFlowLayout() {
        let layout = MiniGalleryFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 210)
        layout.scrollDirection = .horizontal
        layout.spacingMode = .fixed(spacing: 0)
        videoCollectionView.collectionViewLayout = layout
        videoCollectionView.register(UINib(nibName: videoIdentifier, bundle: nil), forCellWithReuseIdentifier: videoIdentifier)
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
    }
    
    fileprivate func setupPhotoFlowLayout() {
        let layout = MiniGalleryFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.scrollDirection = .horizontal
        layout.spacingMode = .overlap(visibleOffset: 30)
        photoCollectionView.collectionViewLayout = layout
        photoCollectionView.register(UINib(nibName: photoIdentifier, bundle: nil), forCellWithReuseIdentifier: photoIdentifier)
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    fileprivate func fetchMiniGalleryData() {
        photoVM.fetchGalleryData {
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
                self.videoCollectionView.reloadData()
            }
        }
    }
}

extension MainViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoVM.miniGalleryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == videoCollectionView {
            let cell: VideoCell  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: videoIdentifier, for: indexPath) as! VideoCell
            cell.videoModel = photoVM.miniGalleryModel[indexPath.item]
            return cell

        } else if collectionView == photoCollectionView {
            let cell: PhotoCell  = photoCollectionView.dequeueReusableCell(withReuseIdentifier: photoIdentifier, for: indexPath) as! PhotoCell
            cell.photoModel = photoVM.miniGalleryModel[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
            
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == videoCollectionView {
            let offset = videoCollectionView.contentOffset.x
            currentPage = offset > 0 ? Int(floor(offset / scrollView.frame.width) + 1) : Int(floor(offset / scrollView.frame.width))
            photoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        } else if scrollView == photoCollectionView {
            let pageSide = self.pageSize.width
            let offset = scrollView.contentOffset.x
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
            videoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
