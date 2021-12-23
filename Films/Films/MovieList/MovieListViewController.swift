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
    
    private var categoryMovies: MovieCagegoriesModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMovieCategories.dataSource = self
        tableViewMovieCategories.delegate = self
        tableViewMovieCategories.register(UINib(nibName: "MovieCategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: Constants.CellNames.movieCategoryTableViewCell)
        
        downloadCategoriesMovies ()
    }
    
    @IBAction func onSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            let movieList = PopularMoviesViewController()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func reloadTableDataContent (){
        DispatchQueue.main.async {
            self.tableViewMovieCategories.reloadData()
        }
    }
    
    private func downloadCategoriesMovies (){
        
        NetworkManager.instance.makeRequest(endpointToExecute: .getAllCategoriesMovies).subscribe { [weak self] responseServer in
            do{
                self?.categoryMovies = try JSONDecoder().decode(MovieCagegoriesModel.self, from: responseServer.data)
                self?.reloadTableDataContent()
            }
            catch {
                print ("Error onSuccess recibiendo lista de getAllMovies: \(error)")
            }
        } onError: { errorReceived in
            print ("Error downloading categories movies: \(errorReceived)")
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMovies?.listAllCagegories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.movieCategoryTableViewCell, for: indexPath) as! MovieCategoryTableViewCell
        
        cell.setCategorySectionData(category: (categoryMovies?.listAllCagegories[indexPath.row])!)
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
