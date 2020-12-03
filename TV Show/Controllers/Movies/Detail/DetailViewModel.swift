//
//  DetialViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import Foundation

class DetailViewModel {
    var movieDetail: MovieDetail!
    
    //MARK: load API
    func loadAPI(movieID: Int, completion: @escaping Completion) -> Void{
        let urlString: String = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=1773fd4bacdaef5a98eb79a383b4fbe1&language=en-US"
        Networking.shared().request(with: urlString) { (data, error) in
            DispatchQueue.main.async { [self] in
                if let error = error {
                    completion(false, error.localizedDescription)
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        self.movieDetail = MovieDetail(json: json)
                        
                        completion(true, "")
                        
                    } else {
                        completion(false, "Data format is error")
                    }
                    
                }
            }
            
        }
    
    }
}
