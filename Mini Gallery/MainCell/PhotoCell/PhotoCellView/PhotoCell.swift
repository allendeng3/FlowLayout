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
            guard let imageUrl = photoModel?.imageUrl else { return }
            self.photoImgView.imageFromURL(imageUrl, placeholder: UIImage(named: "default")!, shouldCacheImage: true, closure: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
