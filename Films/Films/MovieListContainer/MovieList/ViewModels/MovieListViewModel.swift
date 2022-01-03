//
//  MovieListViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation
import RxSwift

class MovieListViewModel: BaseViewModel {
    var categoryMovies: [MovieCagegory]?
    private weak var selectedMovieDelegate: SelectedMovie?
    init(selectedMovieDelegate: SelectedMovie) {
        self.selectedMovieDelegate = selectedMovieDelegate
    }

    func downloadCategoriesMovies () {
        NetworkManager.shared.execute(toExecute: .getAllCategories) { [weak self] (dataDecoded: MovieCagegoriesModel) -> Void in
            self?.categoryMovies = dataDecoded.listAllCagegories
            self?.downloadDataDelegate?.onDownloadDataCorrect()
        } onError: { [weak self] error in
            self?.downloadDataDelegate?.onDownloadDataError(errorReceived: error)
        }
    }

    func saveOffsetCategory (nameCategory: String, offset: CGPoint) {
        if let row = categoryMovies?.firstIndex(where: {$0.nameCategory == nameCategory}) {
            categoryMovies![row].scrollCategoryOffset = offset
        }
    }

    func goToDetailMovieID (_ idMovie: Int) {
        selectedMovieDelegate?.onSelectedMovie(idMovie: idMovie)
    }
}
