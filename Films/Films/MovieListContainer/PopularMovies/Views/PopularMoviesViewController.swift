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

class PopularMoviesViewController: BaseViewController {
    var viewModel: PopularMoviesViewModel?
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private var searchBarHeaderTable: UISearchBar?
    private var filterPopularMovies: [MoviesData]?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PopularMovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: GlobalConstants.CellNames.popularMovieCell)

        viewModel?.downloadDataDelegate = self
        viewModel?.downloadPopularListMovies()

        addHeaderFilter()
        showTable(isVisible: false)
    }

    private func addHeaderFilter () {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
        searchBar.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        searchBar.placeholder = "Search movie..."

        searchBar.rx.text.orEmpty.distinctUntilChanged().subscribe { [weak self] textValue in
            self?.filterPopularMovies = self?.viewModel?.popularMovies?.filter { $0.originalTitle.lowercased().contains(textValue.lowercased()) }
            self?.tableView.reloadData()
        } onError: { error in
            print("Error filtering data movies in popular movies: \(error)")
        }.disposed(by: disposeBag)

        tableView.tableHeaderView = searchBar

        searchBarHeaderTable = searchBar
    }

    private func showTable (isVisible: Bool) {
        if isVisible {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            tableView.isHidden = false
        } else {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            tableView.isHidden = true
        }
    }
}

extension PopularMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarHeaderTable?.text != nil &&  searchBarHeaderTable?.text?.isEmpty == false {
            return filterPopularMovies?.count ?? 0
        } else {
            return viewModel?.popularMovies?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.CellNames.popularMovieCell, for: indexPath) as! PopularMovieTableViewCell

        if searchBarHeaderTable?.text != nil &&  searchBarHeaderTable?.text?.isEmpty == false {
            if let movieData = filterPopularMovies?[indexPath.row] {
                cell.setData(movieData: movieData)
            }
        } else {
            if let movieData = viewModel?.popularMovies?[indexPath.row] {
                cell.setData(movieData: movieData)
            }
        }
        return cell
    }
}

extension PopularMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let idMovie = viewModel?.popularMovies?[indexPath.row].id {
            viewModel?.goToDetailMovieID(idMovie)
        }
    }
}

extension PopularMoviesViewController: DownloadDataFromView {
    func onDownloadDataCorrect() {
        showTable(isVisible: true)
        tableView.reloadData()
    }

    func onDownloadDataError(errorReceived: NetworkError) {
        showAlertError(errorMessage: errorReceived.localizedDescription)
        print("Error receiving data from Popular Movies: typeError\(errorReceived.type) \(errorReceived.description)")
    }
}
