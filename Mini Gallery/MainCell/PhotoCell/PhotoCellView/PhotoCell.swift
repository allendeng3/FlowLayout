//
//  PhotoCell.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/5.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImgView: UIImageView!
    
    var photoModel: MiniGalleryModel? {
        didSet {
//            // 增加imageUrl不为空
//            guard let imageUrl = photoModel?.imageUrl, !imageUrl.isEmpty else { return }
//            self.photoImgView.imageFromURL(imageUrl,
//                                           placeholder: UIImage(named: "default")!,
//                                           shouldCacheImage: true,
//                                           closure: nil)
            // if let
            if let imageUrl = photoModel?.imageUrl {
                self.photoImgView.imageFromURL(imageUrl,
                                               placeholder: UIImage(named: "default")!,
                                               shouldCacheImage: true,
                                               closure: nil)
            }
//            // 设置default value
//            self.photoImgView.imageFromURL(optionStr(photoModel?.imageUrl),
//            placeholder: UIImage(named: "default")!,
//            shouldCacheImage: true,
//            closure: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
