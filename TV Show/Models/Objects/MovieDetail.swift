//
//  MovieDetail.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import Foundation
import UIKit

final class MovieDetail {
    var releaseDate: String
    var imdb: String
    var overview: String
    var title: String
    var posterPath: String
    var posterImage: UIImage?
    
    init(json: JSON) {
        self.releaseDate = json["release_date"] as! String
        self.imdb = "\(json["vote_average"] as! NSNumber)"
        self.overview = json["overview"] as! String
        self.title = json["title"] as! String
        self.posterPath = json["poster_path"] as! String
    }
}
