//
//  String+Extension.swift
//  TV Show
//
//  Created by Hao Kim on 1/1/21.
//

import UIKit

extension String {
    var generateThumbPath: String {
        return "https://image.tmdb.org/t/p/w185" + self
    }                           

    func downloadImage(completion: @escaping ((UIImage?) -> Void)) {
        Networking.shared().downloadImage(url: self) { result in
            switch result {
            case .failure(_):
                completion(nil)
            case .success(let image):
                completion(image)
            }
        }
    }
}
