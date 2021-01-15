//
//  Networking.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation
import UIKit

final class Networking {
    //singleton design pattern
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()
    class func shared() -> Networking {
        return sharedNetworking
    }
    
    private init() {
    }
    
    //MARK: Request
    func request(with urlString: String, completion: @escaping (APIResult) -> Void) {
        guard let url = URL(string: urlString) else {
            // ??
            completion( .failure(.erroURL))
            return
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    if let data = data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.error("Data is nil")))
                    }
                }
            }
        }
        task.resume()
    }
    //MARK: Downloader
    func downloadImage(url: String, completion: @escaping APICompletion<UIImage?>) {
        guard let url = URL(string: url) else {
            completion(.failure(APIError.erroURL))
            return
        }
        
//        let config = URLSessionConfiguration.default
//        config.waitsForConnectivity = true

//        let session = URLSession(configuration: config)
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    if let data = data {
                        completion(.success(UIImage(data: data)))
                    }
                }
            }
        }
        task.resume()
    }
}
