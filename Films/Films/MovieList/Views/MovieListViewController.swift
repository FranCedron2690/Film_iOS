//
//  MovieListViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit
import Moya
import RxSwift

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var viewContentLists: UIView!
    @IBOutlet weak var tableViewMovieCategories: UITableView!
    var viewModel: MovieListViewModel?
    
    private var categoryMovies: [MovieCagegory]?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMovieCategories.dataSource = self
        tableViewMovieCategories.delegate = self
        tableViewMovieCategories.register(UINib(nibName: "MoviesListByCategoryViewCell", bundle: Bundle.main), forCellReuseIdentifier: Constants.CellNames.movieCategoryTableViewCell)
        
        viewModel = MovieListViewModel()
        viewModel?.view = self 
        viewModel?.downloadDataDelegate = self
        viewModel?.downloadCategoriesMovies()
    }
    
    private func reloadTableDataContent (){
        DispatchQueue.main.async {
            self.tableViewMovieCategories.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.movieCategoryTableViewCell, for: indexPath) as! MoviesListByCategoryViewCell
        
        cell.setCategorySectionData(category: (categoryMovies?[indexPath.row])!)
        cell.selectedMovieDelegate = self
        
        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
}

extension MovieListViewController: SelectedMovie {
    func onSelectedMovie(movieID: Int) {
        let movieDetailView = MovieDetailViewController()
        movieDetailView.movieID = movieID
        self.navigationController?.pushViewController(movieDetailView, animated: true)
    }
}

extension MovieListViewController: DownloadDataFromView {
    func onDownloadDataCorrect(categories: [MovieCagegory]) {
        categoryMovies = categories
        reloadTableDataContent()
    }
    
    func onDownloadDataError(errorReceived: Error) {
        print ("Error receiving categories movie data: \(errorReceived)")
    }
}
