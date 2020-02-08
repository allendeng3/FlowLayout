//
//  MiniGalleryModel.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/8.
//  Copyright © 2020 Allen. All rights reserved.
//

import Foundation

struct MiniGalleryModel {
    var id: Int!
    var imageUrl: String!
    var videoUrl: String!
    
    init(_ dic: [String: AnyObject]) {
        self.id = dic["id"] as? Int
        self.imageUrl = dic["imageUrl"] as? String
        self.videoUrl = dic["videoUrl"] as? String
    }
}

