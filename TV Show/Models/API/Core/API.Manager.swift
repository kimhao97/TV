//
//  API.Manager.swift
//  TV Show
//
//  Created by Hao Kim on 12/31/20.
//

import Foundation

struct APIManager {
    struct path {
        static let base_domain: String = "https://api.themoviedb.org"
        static let base_path: String = "/3/movie"
        
        static let popular_path: String = "/popular"
        static let nowPlaying_path: String = "/now_playing"
        static let topRated_path: String = "/top_rated"
        static let upcoming_path: String = "/upcoming"
        static let credits_path: String = "/credits"
        
        static let APIKey_path: String = "?api_key="
        static let APIKey: String = "1773fd4bacdaef5a98eb79a383b4fbe1"
        
        static let language_path: String = "&language=en-US"
        static let page_path: String = "&page=1"
    }
    struct Movie {}
    struct Favorite {}
    struct Setting {}
}
