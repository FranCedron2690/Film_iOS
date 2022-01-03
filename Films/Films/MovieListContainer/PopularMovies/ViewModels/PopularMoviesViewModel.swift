//
//  PopularMoviesViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import Foundation
import RxSwift
import Moya

class PopularMoviesViewModel: BaseViewModel {

    var popularMovies: [MoviesData]?
    private weak var selectedMovieDelegate: SelectedMovie?

    init(selectedMovieDelegate: SelectedMovie) {
        self.selectedMovieDelegate = selectedMovieDelegate
    }

    func downloadPopularListMovies() {
        NetworkManager.shared.execute(toExecute: .getPopularMovies) { [weak self] (dataDecoded: MovieListModel) -> Void in
            self?.popularMovies = dataDecoded.results
            self?.downloadDataDelegate?.onDownloadDataCorrect()
        } onError: {  [weak self] errorReceived in
            self?.downloadDataDelegate?.onDownloadDataError(errorReceived: errorReceived)
        }
    }

    func goToDetailMovieID (_ id: Int) {
        selectedMovieDelegate?.onSelectedMovie(idMovie: id)
    }
}
