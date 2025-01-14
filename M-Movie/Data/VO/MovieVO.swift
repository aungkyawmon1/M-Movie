//
//  MovieVO.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

// MARK: - MovieVO
struct MovieVO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func convertToRO() -> MovieRO {
        let movieRO = MovieRO()
        movieRO.adult = adult
        movieRO.backdropPath = backdropPath
        movieRO.genreIDS.append(objectsIn: genreIDS ?? [])
        movieRO.id = id
        movieRO.originalLanguage = originalLanguage
        movieRO.originalTitle = originalTitle
        movieRO.popularity = popularity
        movieRO.posterPath = posterPath
        movieRO.overview = overview
        movieRO.releaseDate = releaseDate
        movieRO.title = title
        movieRO.video = video
        movieRO.voteAverage = voteAverage
        movieRO.voteCount = voteCount
        
        return movieRO
    }
}

