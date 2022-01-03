//
//  MovieListViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit
import Moya
import RxSwift

class MovieListViewController: BaseViewController {

    @IBOutlet weak var viewContentLists: UIView!
    @IBOutlet weak var tableViewMovieCategories: UITableView!
    var viewModel: MovieListViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMovieCategories.dataSource = self
        tableViewMovieCategories.delegate = self
        tableViewMovieCategories.register(UINib(nibName: "MoviesListByCategoryViewCell", bundle: Bundle.main), forCellReuseIdentifier: Constants.CellNames.movieCategoryTableViewCell)

        viewModel?.downloadDataDelegate = self
        viewModel?.downloadCategoriesMovies()
    }

    private func reloadTableDataContent () {
        DispatchQueue.main.async {
            self.tableViewMovieCategories.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categoryMovies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.movieCategoryTableViewCell, for: indexPath) as! MoviesListByCategoryViewCell

        if let lastCategoryOffsetData = cell.getCategoryOffset() {
            viewModel?.saveOffsetCategory(nameCategory: lastCategoryOffsetData.nameCategory, offset: lastCategoryOffsetData.offset)
        }

        if let category = viewModel?.categoryMovies?[indexPath.row] {
            cell.setCategorySectionData(category)
        }

        cell.selectedMoviePosterDelegate = self

        return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
}

extension MovieListViewController: SelectedMoviePoster {
    func onSelectedMoviePoster(movieID: Int) {
        viewModel?.goToDetailMovieID(movieID)
    }
}

extension MovieListViewController: DownloadDataFromView {
    func onDownloadDataCorrect() {
        reloadTableDataContent()
    }

    func onDownloadDataError(errorReceived: NetworkError) {
        showAlertError(errorMessage: errorReceived.localizedDescription)
        print("Error receiving categories movie data: \(errorReceived)")
    }
}
