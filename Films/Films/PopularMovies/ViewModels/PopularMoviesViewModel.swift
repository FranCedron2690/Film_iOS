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
    
    weak var view: PopularMoviesViewController?
    
    func downloadPopularListMovies() {
        NetworkManager.instance.makeRequest(endpointToExecute: .getPopularMovies).subscribe { [weak self] response in
            do {
                let decodeData = try JSONDecoder().decode(MovieListModel.self, from: response.data)
                self?.downloadDataDelegate?.onDownloadDataCorrect(movies: decodeData.results)
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
