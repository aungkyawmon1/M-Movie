//
//  MovieRO.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import RealmSwift

class MovieRO: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var genreIDS: List<Int>
    @Persisted var originalLanguage: String?
    @Persisted var originalTitle: String?
    @Persisted var overview: String?
    @Persisted var popularity: Double?
    @Persisted var posterPath: String?
    @Persisted var releaseDate: String?
    @Persisted var title: String?
    @Persisted var video: Bool?
    @Persisted var voteAverage: Double?
    @Persisted var voteCount: Int?
    @Persisted var isFavorite: Bool?
    @Persisted var movieType: List<String>
    
}
