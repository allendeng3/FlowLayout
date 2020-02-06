//
//  NetworkRequest.swift
//  Mini Gallery
//
//  Created by Allen_鄧 on 2020/2/5.
//  Copyright © 2020 Allen. All rights reserved.
//

import UIKit

class NetworkRequest: UIViewController {
        
    static let shared: NetworkRequest = {
        let instance = NetworkRequest()        
        return instance
    }()
    func dataRequest(completion: @escaping (JSON, Error?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: "https://private-04a55-videoplayer1.apiary-mock.com/pictures")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil { return }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                completion(JSON(json), nil)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
