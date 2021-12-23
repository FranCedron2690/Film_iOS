//
//  PopularMoviesViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var popularMovies: [MoviesData]?
    private var filterPopularMovies: [MoviesData]?
    private var searchBarHeaderTable:UISearchBar?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PopularMovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: Constants.CellNames.popularMovieCell)
        
        addHeaderFilter ()
        showTable(isVisible: false)
        downloadPopularListMovies()
    }
    
    @IBAction func onSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let popularMovieList = MovieListViewController()
            self.navigationController?.pushViewController(popularMovieList, animated: true)
        }
    }
    
    private func addHeaderFilter () {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
        searchBar.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        searchBar.placeholder = "Search movie..."
        
        searchBar.rx.text.orEmpty.distinctUntilChanged().subscribe { [weak self] textValue in
            self?.filterPopularMovies = self?.popularMovies?.filter{ $0.originalTitle.lowercased().contains(textValue.lowercased()) }
            self?.tableView.reloadData()
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
        tableView.tableHeaderView = searchBar
        
        searchBarHeaderTable = searchBar
    }
    
    private func showTable (isVisible:Bool) {
        if isVisible {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            tableView.isHidden = false
        }
        else {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            tableView.isHidden = true
        }
    }
    
    private func downloadPopularListMovies() {
        NetworkManager.instance.makeRequest(endpointToExecute: .getPopularMovies).subscribe { [weak self] response in
            do {
                let decodeData = try JSONDecoder().decode(MovieListModel.self, from: response.data)
                self?.popularMovies = decodeData.results
                self?.showTable(isVisible: true)
                self?.tableView.reloadData()
            }
            catch {
                print ("Error decoding data from popular movies: \(error)")
            }
        } onError: { errorReceived in
            print ("Error receiving data from popular movies: \(errorReceived)")
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarHeaderTable?.text != nil &&  searchBarHeaderTable?.text?.isEmpty == false{
            return filterPopularMovies?.count ?? 0
        }
        else {
            return popularMovies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.popularMovieCell, for: indexPath) as! PopularMovieTableViewCell
        
        if searchBarHeaderTable?.text != nil &&  searchBarHeaderTable?.text?.isEmpty == false{
            if let movieData = filterPopularMovies?[indexPath.row] {
                cell.setData(movieData:movieData)
            }
        }
        else {
            if let movieData = popularMovies?[indexPath.row] {
                cell.setData(movieData:movieData)
            }
        }
        
        return cell
    }
}

extension PopularMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movieDetailView = MovieDetailViewController()
        movieDetailView.movieID = popularMovies?[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailView, animated: true)
    }
}
