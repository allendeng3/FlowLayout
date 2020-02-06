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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPhotoCell(_ imageUrl: String) {
        photoImgView.imageFromURL(imageUrl, placeholder: UIImage(named: "default")!)
    }
}
