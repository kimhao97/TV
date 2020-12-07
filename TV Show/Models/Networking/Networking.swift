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
    
    //MARK: init
    private init() {
    }
    
    //MARK: request
    func request(with urlString: String, completion: @escaping (Data?, APIError?) -> Void) {
        guard let url = URL(string: urlString) else {
            // ??
            completion( nil, APIError.erroURL)
            return
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, APIError.error(error.localizedDescription))
                } else {
                    if let data = data {
                        completion(data, nil)
                    } else {
                        completion(nil, APIError.error("Data format is error"))
                    }
                }
            }
        }
        task.resume()
    }
    //MARK: downloader
    func download(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            print("1")
            return
        }
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(nil)
                } else {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
    
//    //MARK: -Realm
//    
//    //fetch data
//    func fetchDataRealm() {
//
//    }
}
