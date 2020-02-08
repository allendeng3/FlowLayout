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
    
    fileprivate var mainViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        mainViewModel.videoCollectionView = videoCollectionView
        mainViewModel.setupCollectionView(.video)

        mainViewModel.photoCollectionView = photoCollectionView
        mainViewModel.setupCollectionView(.photo)
    }
}


