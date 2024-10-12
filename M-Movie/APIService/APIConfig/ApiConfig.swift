//
//  ApiConfig.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class ApiConfig {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    enum Movie {
        case upcoming
        case popular
        
        func getUrlString() -> String {
            switch self {
            case .upcoming:
                return ApiConfig.baseUrl + "movie/upcoming"
            case .popular:
                return ApiConfig.baseUrl + "movie/popular"
            }
        }
    }
}
