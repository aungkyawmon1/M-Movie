//
//  MovieRepository.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import RxSwift
import RealmSwift

protocol MovieRepository {
    func saveMovies(movieVOs: [MovieVO], type: MovieType)
    func getMovie(type: MovieType) -> Observable<[MovieRO]>
    func getMovie(at id: Int) -> Observable<MovieRO?>
    func updateFavorite(id: Int, isFavorite: Bool )
}

class MovieRepositoryImp: BaseRepository, MovieRepository {
    
    static let shared: MovieRepository = MovieRepositoryImp()
    
    
    func saveMovies(movieVOs: [MovieVO], type: MovieType) {
        movieVOs.forEach { movieVO in
            // Check movie is exist or not.
            if let movieRO = realmInstance.object(ofType: MovieRO.self, forPrimaryKey: movieVO.id ?? 0) {
                //If exist, update the movie attributs only
                do {
                    try realmInstance.write({
                        movieRO.adult = movieVO.adult
                        movieRO.backdropPath = movieVO.backdropPath
                        movieRO.genreIDS.append(objectsIn: movieVO.genreIDS ?? [])
                        movieRO.originalLanguage = movieVO.originalLanguage
                        movieRO.originalTitle = movieVO.originalTitle
                        movieRO.popularity = movieVO.popularity
                        movieRO.posterPath = movieVO.posterPath
                        movieRO.overview = movieVO.overview
                        movieRO.releaseDate = movieVO.releaseDate
                        movieRO.title = movieVO.title
                        movieRO.video = movieVO.video
                        movieRO.voteAverage = movieVO.voteAverage
                        movieRO.voteCount = movieVO.voteCount
                        if !movieRO.movieType.contains(type.rawValue) {
                            movieRO.movieType.append(type.rawValue)
                        }
                    })
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                //If not exist, add the movie attributs with default favorite value
                let movieRO = movieVO.convertToRO()
                movieRO.isFavorite = false
                movieRO.movieType.append(type.rawValue)
                do {
                    try realmInstance.write({
                        realmInstance.add(movieRO)
                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Fetch movies based on movie type
    func getMovie(type: MovieType) -> RxSwift.Observable<[MovieRO]> {
        return Observable.create { observer in
            // Get the initial results
            let results = self.realmInstance.objects(MovieRO.self).filter("ANY movieType CONTAINS[c] %@", type.rawValue)
            
            // Send the current state to the observer
            observer.onNext(Array(results))
            
            // Set up a notification token to observe changes
            let token = results.observe { changes in
                switch changes {
                case .initial(let initialResults):
                    // Send initial results
                    observer.onNext(Array(initialResults))
                case .update(let updatedResults, _, _, _):
                    // Send updated results when data changes
                    observer.onNext(Array(updatedResults))
                case .error(let error):
                    // Send any errors to the observer
                    observer.onError(error)
                }
            }
            
            // Dispose of the token when the observable is disposed
            return Disposables.create {
                token.invalidate()
            }
        }
    }
    
    func getMovie(at id: Int) -> Observable<MovieRO?> {
        return Observable.create { observer in
            // Fetch the initial movie object based on its ID
            let movieRO = self.realmInstance.object(ofType: MovieRO.self, forPrimaryKey: id)
            
            // Send the current state to the observer
            observer.onNext(movieRO)
            
            // If the object is nil, we can return immediately
            guard let movie = movieRO else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            // Set up a notification token to observe changes
            let token = self.realmInstance.observe { [weak self] notification, realm in
                // Fetch the updated movie object
                if let updatedMovieRO = realm.object(ofType: MovieRO.self, forPrimaryKey: id) {
                    // Send updated object to the observer
                    observer.onNext(updatedMovieRO)
                } else {
                    // If the movie object no longer exists, send nil
                    observer.onNext(nil)
                }
            }
            
            // Dispose of the token when the observable is disposed
            return Disposables.create {
                token.invalidate()
            }
        }
    }
    
    
    // Update the favorite column
    func updateFavorite(id: Int, isFavorite: Bool ) {
        if let movieRO = realmInstance.object(ofType: MovieRO.self, forPrimaryKey: id) {
            
            do {
                try realmInstance.write({
                    movieRO.isFavorite = isFavorite
                })
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}
