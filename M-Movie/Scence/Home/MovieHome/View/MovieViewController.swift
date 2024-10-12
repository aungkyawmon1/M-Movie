//
//  MovieViewController.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

class MovieViewController: BaseViewController, MovieCategoryDelegate {

    @IBOutlet weak var tableViewMovies: UITableView!
    
    let viewModel = MovieViewModel()
    
    weak var delegate: MovieFavoriteDelegate?
    
    // Custom initializer if needed
    init() {
        super.init(nibName: nil, bundle: nil) // Use this if not using a XIB
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        viewModel.getPopular()
        
        viewModel.getUpcoming()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.bindViewModel(in: self)
    }

    override func registerCell() {
        tableViewMovies.registerForCells(cells: MovieCategoryTVCell.self)
        tableViewMovies.dataSource = self
        tableViewMovies.delegate = self
    }
    
    override func bindData() {
        viewModel.moviePublishRelay.subscribe(onNext: { movie in
            guard let _ = movie else { return }
            self.tableViewMovies.reloadData()
        }).disposed(by: disposeBag)
        
    }
    

    func updateFavorite(movieRO: MovieRO) {
        viewModel.updateFavorite(movieRO: movieRO)
    }
    
    func selectMovie(movieRO: MovieRO) {
        let vc = MovieDetailViewController()
        vc.viewModel = MovieDetailViewModel(movieID: movieRO.id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: MovieCategoryTVCell.self, indexPath: indexPath)
        cell.delegate = self
        switch viewModel.getMovieType(at: indexPath.row) {
        
        case .popular:
            cell.title = "POPULAR"
            cell.movies = viewModel.popularMovies
        case .upcoming:
            cell.title = "UPCOMING"
            cell.movies = viewModel.upComingMovies
        }
        
        return cell
    }

    
}
