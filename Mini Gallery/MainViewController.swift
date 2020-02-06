//
//  MainViewController.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/5.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: videoIdentifier)
            videoCollectionView.delegate = self
            videoCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var photoCollectionView: UICollectionView! {
        didSet {
            photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: photoIdentifier)
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let videoIdentifier = "VideoCell"
    fileprivate let photoIdentifier = "PhotoCell"
    fileprivate var currentPage: Int = 0
    fileprivate var miniGalleryData = JSON()

    fileprivate var pageSize: CGSize {
        let layout = self.photoCollectionView.collectionViewLayout as! MiniGalleryFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPhotoFlowLayout()
        setupVideoFlowLayout()
        fetchMiniGalleryData()
    }
            
    fileprivate func setupPhotoFlowLayout() {
        let layout = MiniGalleryFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.scrollDirection = .horizontal
        layout.spacingMode = .overlap(visibleOffset: 30)
        photoCollectionView.collectionViewLayout = layout
    }
    
    fileprivate func setupVideoFlowLayout() {
        let layout = MiniGalleryFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 210)
        layout.scrollDirection = .horizontal
        layout.spacingMode = .fixed(spacing: 0)
        videoCollectionView.collectionViewLayout = layout
    }
    
    fileprivate func fetchMiniGalleryData() {
        activityIndicator.startAnimating()
        NetworkRequest.shared.dataRequest { (data, error) in
            guard error == nil else { return }
            self.miniGalleryData = data
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
                self.videoCollectionView.reloadData()
            }
        }
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miniGalleryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == videoCollectionView {
            let cell: VideoCell  = videoCollectionView.dequeueReusableCell(withReuseIdentifier: videoIdentifier, for: indexPath) as! VideoCell
            cell.setVideoCell(miniGalleryData[indexPath.row]["videoUrl"].string!)
            return cell
        } else if collectionView == photoCollectionView {
            let cell: PhotoCell  = photoCollectionView.dequeueReusableCell(withReuseIdentifier: photoIdentifier, for: indexPath) as! PhotoCell
            cell.setPhotoCell(miniGalleryData[indexPath.row]["imageUrl"].string!)
            return cell
        }
        return UICollectionViewCell()
    }

    /// MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == videoCollectionView {
            let offset = videoCollectionView.contentOffset.x
            currentPage = offset > 0 ? Int(floor(offset / scrollView.frame.width) + 1) : Int(floor(offset / scrollView.frame.width))
            photoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
        
        if scrollView == photoCollectionView {
            let pageSide = self.pageSize.width
            let offset = scrollView.contentOffset.x
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
            videoCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

