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
            
    var videoModel: MiniGalleryModel! {
        didSet {
//            // 增加VideoUrl不为空
//            guard let videoUrl = videoModel?.videoUrl, !videoUrl.isEmpty else { return }
//            let videoAsset = AVAsset(url: URL(string: videoUrl)!)
//            let videoPlayerItem = AVPlayerItem(asset: videoAsset)
//            player = AVPlayer(playerItem: videoPlayerItem)
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.bounds
//            playerLayer.videoGravity = .resize
//            playerView.layer.addSublayer(playerLayer)
//            player.play()
            
            // if let 
            if let videoUrl = videoModel?.videoUrl {
                let videoAsset = AVAsset(url: URL(string: videoUrl)!)
                let videoPlayerItem = AVPlayerItem(asset: videoAsset)
                player = AVPlayer(playerItem: videoPlayerItem)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.bounds
                playerLayer.videoGravity = .resize
                playerView.layer.addSublayer(playerLayer)
                player.play()
            }
            
//            // 设置default value
//            let videoAsset = AVAsset(url: URL(string: optionStr(videoModel?.videoUrl))!)
//            let videoPlayerItem = AVPlayerItem(asset: videoAsset)
//            player = AVPlayer(playerItem: videoPlayerItem)
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.bounds
//            playerLayer.videoGravity = .resize
//            playerView.layer.addSublayer(playerLayer)
//            player.play()
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
