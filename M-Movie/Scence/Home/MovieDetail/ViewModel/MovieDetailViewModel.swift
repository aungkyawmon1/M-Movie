//
//  MovieDetailViewModel.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailViewModel : BaseViewModel {
    
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    private let movieID : Int
    
    private var movieRO: MovieRO?
    
    let moviePublishRelay = PublishRelay<MovieRO?>()
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    func getDetail() {
        movieModel.getMovie(at: movieID).subscribe(onNext: { movieRO in
            self.movieRO = movieRO
            self.moviePublishRelay.accept(movieRO)
        }).disposed(by: disposeBag)
    }
    
    func updateFavorite() {
        guard let movieRO = movieRO else { return }
        movieModel.updateFavorite(id: movieRO.id ?? 0, isFavorite: !(movieRO.isFavorite ?? false))
    }
    
    
}

