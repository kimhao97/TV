//
//  MoviesViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation

//how to manager typealias ??
typealias  Completion = (Bool, String) -> Void
class MoviesViewModel {
    var movies: [Movie] = []
    
    //load API
    func loadAPI(completion: @escaping Completion) -> Void {
        let urlString: String = "https://api.themoviedb.org/3/movie/popular?api_key=1773fd4bacdaef5a98eb79a383b4fbe1&language=en-US&page=1"
        
        Networking.shared().request(with: urlString) {(data, error) in
            if let error = error {
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
}
