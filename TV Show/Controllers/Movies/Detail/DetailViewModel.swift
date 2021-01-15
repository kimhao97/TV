//
//  DetialViewModel.swift
//  TV Show
//
//  Created by Hao Kim on 11/25/20.
//

import Foundation
import UIKit

final class DetailViewModel {
    //MARK: -Properties
    private var movieID: Int
    var movieDetail: MovieDetail!
    var credits: [Credits] = []
    
    // MARK: - Initialize
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    // MARK: - Computed Properties
//    var thumbnail: UIImage? {
//        getThumbnail(thumbnailPath: movieDetail.posterPath) { image in
//            if let image = image {
//                return image
//            }
//            return nil
//        }
//    }
    
    func fetchMovieDetail(completion: @escaping Completion) {
        APIManager.Movie.getMovieDetail(movieID: movieID) { result in
            switch result {
            case .failure(let error):
                completion(false, error.localizedDescription)
            case .success(let data):
                self.movieDetail = data
                completion(true, "")
            }
        }
    }
    func fetchCredits(completion: @escaping Completion) {
        APIManager.Movie.getCredits(movieID: movieID) { result in
            switch result {
            case .failure(let error):
                completion(false, error.localizedDescription)
            case .success(let data):
                self.credits.removeAll()
                self.credits = data
                for item in self.credits {
                    completion(true, "")
                  }
            }
        }
    }
    func getThumbnail(thumbnailPath: String?,completion: @escaping (UIImage?) -> ()){
        if let thumbnailPath = thumbnailPath {
            let urlString = thumbnailPath.generateThumbPath
                
            urlString.downloadImage(completion: completion)
        }
    }
}

//MARK: load API
//    func loadAPI(movieID: Int, completion: @escaping Completion) -> Void{
//        let urlString: String = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=1773fd4bacdaef5a98eb79a383b4fbe1&language=en-US"
//        Networking.shared().request(with: urlString) {  result in
//            DispatchQueue.main.async { [self] in
//                switch result {
//                case .failure(let error):
//                    completion(false, error.localizedDescription)
//                case .success(let data):
//                    if let data = data {
//                        let json = data.toJSON()
//                        self.movieDetail = MovieDetail(json: json)
//                        completion(true, "")
//                    }
//                }
//            }
//        }
//    }
