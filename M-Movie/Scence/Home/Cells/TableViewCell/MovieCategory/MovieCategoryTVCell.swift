//
//  MovieCategoryTVCell.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

protocol MovieCategoryDelegate: AnyObject {
    func updateFavorite(movieRO: MovieRO)
    func selectMovie(movieRO: MovieRO)
}

class MovieCategoryTVCell: BaseTableViewCell, MovieFavoriteDelegate {

    @IBOutlet weak var lblMovieType: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    weak var delegate: MovieCategoryDelegate?
    
    var type: MovieType = .upcoming
    
    var movies: [MovieRO]? {
        didSet {
            if let _ = movies {
                collectionViewMovies.reloadData()
            }
        }
    }
    
    var title: String? {
        didSet {
            lblMovieType.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func setupUI() {
        super.setupUI()
        
        registerCells()
    }
    
    func registerCells() {
        
        collectionViewMovies.registerForCells(cells: MovieItemCVCell.self)
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        
    }
    
    func updateFavorite(movieRO: MovieRO) {
        delegate?.updateFavorite(movieRO: movieRO)
    }
    
    
}

extension MovieCategoryTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movie = movies?[indexPath.item] {
        let cell = collectionView.dequeReuseCell(type: MovieItemCVCell.self, indexPath: indexPath)

            cell.delegate = self
            cell.movieRO = movie
            return cell
        } else {
            return UICollectionViewCell()
        }
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = movies else { return }
        delegate?.selectMovie(movieRO: movies[indexPath.item])
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
    
}
