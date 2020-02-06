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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setVideoCell(_ videoUrl: String) {
        let videoAsset = AVAsset(url: URL(string: videoUrl)!)
        let videoPlayerItem = AVPlayerItem(asset: videoAsset)
        let player = AVPlayer(playerItem: videoPlayerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resize
        self.layer.addSublayer(playerLayer)
        player.play()
    }
}
