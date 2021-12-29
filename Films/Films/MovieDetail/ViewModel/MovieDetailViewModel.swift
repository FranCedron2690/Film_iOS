//
//  MovieDetailViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import Foundation
import RxSwift

class MovieDetailViewModel: BaseViewModel {
    
    var movieData:MovieModel?
    
    func downloadMovieDetailData (movieID: Int) {
        NetworkManager.instance.makeRequest(endpointToExecute: .getMovieByID(idMovie: movieID)) { [weak self] (dataDecoded:MovieModel) -> Void in
            self?.movieData = dataDecoded
            self?.downloadDataDelegate?.onDownloadDataCorrect()
        } onError: { [weak self] error in
            self?.downloadDataDelegate?.onDownloadDataError(errorReceived: error)
        }
    }
}
