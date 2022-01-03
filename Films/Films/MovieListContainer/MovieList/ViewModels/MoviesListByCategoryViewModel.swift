//
//  MoviesListByCategoryViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation

class MoviesListByCategoryViewModel: BaseViewModel {
    var categoryMovieSection: MovieCagegory?
    var dataMoviesBySection: MovieListModel?

    func donwloadSectionMoviesData (idCategory: Int) {
        NetworkManager.shared.execute(toExecute: .getMoviesByCategory(idCategory: categoryMovieSection!.idCategory)) { [weak self] (dataDecoded: MovieListModel) -> Void in
            self?.dataMoviesBySection = dataDecoded
            self?.downloadDataDelegate?.onDownloadDataCorrect()
        } onError: {  [weak self] errorReceived in
            self?.downloadDataDelegate?.onDownloadDataError(errorReceived: errorReceived)
        }
    }
}
