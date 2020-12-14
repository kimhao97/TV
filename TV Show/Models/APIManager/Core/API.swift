//
//  API.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import Foundation

enum APIError {
    case error(String)
    case erroURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .erroURL:
            return "URL string is error"
        }
    }
}

//enum APIRouter {
//    case popular, topRated, upcoming, nowPlaying
//
//    static var baseURL: String = "https://api.themoviedb.org/3/movie"
//    static var APIKey: String = "1773fd4bacdaef5a98eb79a383b4fbe1"
//    var path: String {
//        switch self {
//        case .popular:
//            return "/popular?api_key=\(APIRouter.APIKey)&language=en-US&page=1"
//        case .topRated:
//            return "/top_rated?api_key=\(APIRouter.APIKey)&language=en-US&page=1"
//        case .upcoming:
//            return "/upcoming?api_key=\(APIRouter.APIKey)&language=en-US&page=1"
//        case .nowPlaying:
//            return "/now_playing?api_key=\(APIRouter.APIKey)&language=en-US&page=1"
//        }
//    }
//    var isFilterType: String {
//        switch self {
//        case .popular:
//            return "Popular Movies"
//        case .topRated:
//            return "Top Rated Movies"
//        case .upcoming:
//            return "Upcoming Movies"
//        case .nowPlaying:
//            return "NowPlaying Movies"
//        }
//    }
//}

enum SettingType {
    enum FilterType: Int {
        case popular = 0
        case topRated = 1
        case upcoming = 2
        case nowPlaying = 3
        
        static var baseURL: String = "https://api.themoviedb.org/3/movie"
        static var APIKey: String = "1773fd4bacdaef5a98eb79a383b4fbe1"
        var path: String {
            switch self {
            case .popular:
                return "/popular?api_key=\(SettingType.FilterType.APIKey)&language=en-US&page=1"
            case .topRated:
                return "/top_rated?api_key=\(SettingType.FilterType.APIKey)&language=en-US&page=1"
            case .upcoming:
                return "/upcoming?api_key=\(SettingType.FilterType.APIKey)&language=en-US&page=1"
            case .nowPlaying:
                return "/now_playing?api_key=\(SettingType.FilterType.APIKey)&language=en-US&page=1"
            }
        }
        var isFilterType: String {
            switch self {
            case .popular:
                return "Popular Movies"
            case .topRated:
                return "Top Rated Movies"
            case .upcoming:
                return "Upcoming Movies"
            case .nowPlaying:
                return "NowPlaying Movies"
            }
        }
    }

    enum SortByType: Int {
        case releaseDate = 0
        case rating = 1
        
        var isSortByType: String {
            switch self {
            case .releaseDate:
                return "Release Date"
            case .rating:
                return "Rating"
            }
        }
    }
}



