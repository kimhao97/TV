//
//  Movie.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation
import UIKit
final class Movie {
    var title: String
    var releaseDate: String
    var overview: String
    var rating: Float
    var posterpath: String
    var posterImage: UIImage?
    var id: Int
    init(json: JSON) {
        self.title = json["title"] as! String
        self.releaseDate = json["release_date"] as! String
        self.overview = json["overview"] as! String
        self.rating = Float(json["vote_average"] as! NSNumber)
        self.posterpath = json["poster_path"] as! String
        self.id = Int(json["id"] as! NSNumber)
    }
}
