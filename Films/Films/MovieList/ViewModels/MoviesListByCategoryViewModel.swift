//
//  MoviesListByCategoryViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation

class MoviesListByCategoryViewModel: BaseViewModel {
    
    weak var view: MoviesListByCategoryViewCell?
    
    func donwloadSectionMoviesData (idCategory: Int) {
        NetworkManager.instance.makeRequest(endpointToExecute: .getMoviesByCategory(idCategory: idCategory)).subscribe { [weak self] response in
            do {
                let decodedData  = try JSONDecoder().decode(MovieListModel.self, from: response.data)
                self?.downloadDataDelegate?.onDownloadDataCorrect(movies: decodedData.results)
            }
            catch {
                self?.downloadDataDelegate?.onDownloadDataError(errorReceived: error)
            }
        } onError: { [weak self] errorReceived in
            self?.downloadDataDelegate?.onDownloadDataError(errorReceived: errorReceived)
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
    }
}
