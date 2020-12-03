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
