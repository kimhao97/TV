//
//  MovieCellModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/27/20.
//

import Foundation
import UIKit
import RealmSwift
class MovieCellModel {
    var title: String
    var releaseDate: String
    var overview: String
    var rating: String
    var posterpath: String
    var id: Int
//    var posterImage: UIImage?

    init(movie: Movie) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.rating = "\(movie.rating)"
        self.posterpath = movie.posterpath
        self.id = movie.id
//        self.movie = movie
    }
    init(movie: Favorite) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.rating = "\(movie.rating)"
        self.posterpath = movie.posterpath
        self.id = movie.id
    }
    func getTitle() -> String {
        return title
    }
    func getReleaseDate() -> String {
        return releaseDate
    }
    func getRating() -> String {
        return rating
    }
    func getOverview() -> String {
        return overview
    }
    
    func getThumbnail(completion: @escaping (UIImage?) -> ()){
        let urlString: String = "https://image.tmdb.org/t/p/w185" + posterpath
      
        Networking.shared().download(url: urlString) { (image) in
                if let image = image {
//                    self.posterImage = image
                    completion(image)
                }
        }
    }
    
    func getFavoriteImage() -> UIImage {
        let realm = try! Realm()
      
        let result = realm.objects(Favorite.self).filter("id == %@", self.id)
        if result.isEmpty {
            return UIImage(systemName: "star")!
        } else {
            return UIImage(systemName: "star.fill")!
        }
    }
}
