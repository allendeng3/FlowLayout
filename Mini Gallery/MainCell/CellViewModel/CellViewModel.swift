//
//  CellViewModel.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/8.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit

class CellViewModel: NSObject {
    
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
}

