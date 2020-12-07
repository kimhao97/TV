//
//  MoviesViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation
import RealmSwift

typealias  Completion = (Bool, String) -> Void
class MoviesViewModel {
    var movies: [Movie] = []
    
    //MARK: -load API
    func loadAPI(completion: @escaping Completion) -> Void {
        let urlString: String = "https://api.themoviedb.org/3/movie/popular?api_key=1773fd4bacdaef5a98eb79a383b4fbe1&language=en-US&page=1"
        
        Networking.shared().request(with: urlString) {(data, error) in
            if let error = error {
                //callback
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSON()
//                    let feed = json["feed"] as! JSON //check it
                    let results = json["results"] as! [JSON]
                    
                    for item in results {
                        let movie = Movie(json: item)
                        self.movies.append(movie)
                    }
                    completion(true, "")
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
    }
    
    //MARK: -realmData
    func addFavorite(movie: Movie) {
        //create realm Object
        let realm = try! Realm()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let favorite = Favorite()
        favorite.title = movie.title
        favorite.releaseDate = movie.releaseDate
        favorite.overview = movie.overview
        favorite.rating = movie.rating
        favorite.posterpath = movie.posterpath
//        favorite.posterImage = movie.posterImage
        favorite.id = movie.id
        
//        realm.beginWrite()
//        realm.add(favorite)
//        try! realm.commitWrite()
        try! realm.write {
            realm.add(favorite)
        }
    }
    func deleteItem(movie: Movie) {
        let realm = try! Realm()
        
        let itemDelete = realm.objects(Favorite.self).filter("id == %@", movie.id)
        try! realm.write {
            realm.delete(itemDelete)
        }
    }
    func deleteAllFavorite(completion: Completion) {
        do {
            let realm = try! Realm()
            
            let results = realm.objects(Favorite.self)
            
            try realm.write {
                realm.delete(results)
            }
            completion(true, "")
        } catch  {
            completion(false, "Cant delete all item")
        }
    }
     

}
