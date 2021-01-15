//
//  API.Movie.swift
//  TV Show
//
//  Created by Hao Kim on 1/1/21.
//

import Foundation

extension APIManager.Movie {
    struct QueryString {
        func movie() -> String{
            return ""
        }
        func movieDetail(movieID: Int) -> String{
            return APIManager.path.base_domain + APIManager.path.base_path + "/\(movieID)" + APIManager.path.APIKey_path + APIManager.path.APIKey + APIManager.path.language_path + APIManager.path.page_path
        }
        func credit(movieID: Int) -> String{
            return APIManager.path.base_domain + APIManager.path.base_path + "/\(movieID)" + APIManager.path.credits_path + APIManager.path.APIKey_path + APIManager.path.APIKey + APIManager.path.language_path
        }
        
    }
    struct QueryParam {

    }

    static func getCredits(movieID: Int, completion: @escaping APICompletion<[Credits]>) {
        let urlString: String = QueryString().credit(movieID: movieID)
        print(urlString)
        Networking.shared().request(with: urlString) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .failure(let error):
                    completion(.failure(.error(error.localizedDescription)))
                case .success(let data):
                    if let data = data {
                        var creditsResult: [Credits] = []
                        let json = data.toJSON()
                        let results = json["cast"] as! [JSON]
                        for item in results {
                            let credits = Credits(json: item)
                            creditsResult.append(credits)
                        }
                        completion(.success(creditsResult))
                    }
                }
            }
        }
    }
    
    static func getMovieDetail(movieID: Int, completion: @escaping APICompletion<MovieDetail>) {
        
        let urlString: String = QueryString().movieDetail(movieID: movieID)
        
        Networking.shared().request(with: urlString) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .failure(let error):
                    completion(.failure(.error(error.localizedDescription)))
                case .success(let data):
                    if let data = data {
                        let json = data.toJSON()
                        let movieDetail = MovieDetail(json: json)
                        completion(.success(movieDetail))
                    }
                }
            }
        }
    }
}
