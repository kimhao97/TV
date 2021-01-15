//
//  Credits.swift
//  TV Show
//
//  Created by Hao Kim on 1/1/21.
//

import Foundation
import UIKit

final class Credits {
    var castName: String
    var castThumbnail: UIImage?
    var profilePath: String?
//    {
//        didSet {
//            if let profilePath = profilePath {
//                let urlString = profilePath.generateThumbPath
//                urlString.downloadImage() { image in
//                    if let image = image {
//                        self.castThumbnail = image
//                    }
//                }
//            }
//        }
//    }
    
    init(json: JSON) {
        self.castName = json["name"] as! String
        self.profilePath = json["profile_path"] as? String
    }
}
