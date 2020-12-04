//
//  Favorite.swift
//  TV Show
//
//  Created by Hao Kim on 12/4/20.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var rating: Float = 0
    @objc dynamic var posterpath: String = ""
//    @objc dynamic var posterImage: UIImage?
    @objc dynamic var id: Int = 0
    
    //MARK: -ERROR: cannot init
//    init(movie: Movie) {
//        self.title = movie.title
//        self.releaseDate = movie.releaseDate
//        self.overview = movie.overview
//        self.rating = movie.rating
//        self.posterpath = movie.posterpath
//        self.posterImage = movie.posterImage
//        self.id = movie.id
//    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
