//
//  VideoCell.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/5.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {

    @IBOutlet weak var playerView: UIView! 
    
    private var player = AVPlayer()
    private var playerLayer = AVPlayerLayer()
        
    var videoModel: MiniGalleryModel? {
        didSet {
            guard let videoUrl = videoModel?.videoUrl else { return }
            let videoAsset = AVAsset(url: URL(string: videoUrl)!)
            let videoPlayerItem = AVPlayerItem(asset: videoAsset)
            player = AVPlayer(playerItem: videoPlayerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            playerLayer.videoGravity = .resize
            playerView.layer.addSublayer(playerLayer)
            player.play()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
