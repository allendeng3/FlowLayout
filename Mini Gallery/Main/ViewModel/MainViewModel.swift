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
    
    lazy var miniGalleryModel = [MiniGalleryModel]()
 
    func fetchGalleryData(completion: @escaping() -> ()) {
         NetworkRequest.shared.dataRequest { (result) in
             self.miniGalleryModel.removeAll()
             guard let resultDict = result as? [[String: NSObject]] else { return }
             for dict in resultDict {
                 self.miniGalleryModel.append(MiniGalleryModel(dict))
             }
             completion()
         }
     }
    
    func setupColletionViewLayout(_ type: CollectionViewType)-> MiniGalleryFlowLayout {
        if type == .video {
            let videoLayout = MiniGalleryFlowLayout()
            videoLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 210)
            videoLayout.scrollDirection = .horizontal
            videoLayout.spacingMode = .fixed(spacing: 0)
            return videoLayout
        } else if type == .photo {
            let photoLayout = MiniGalleryFlowLayout()
            photoLayout.itemSize = CGSize(width: 60, height: 80)
            photoLayout.scrollDirection = .horizontal
            photoLayout.spacingMode = .overlap(visibleOffset: 30)
            return photoLayout
        }
        return MiniGalleryFlowLayout()
    }
}



