//
//  MovieListViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation
import RxSwift

class MovieListViewModel: BaseViewModel {
    
    weak var view: MovieListViewController?
    
    func downloadCategoriesMovies (){
        
        NetworkManager.instance.makeRequest(endpointToExecute: .getAllCategoriesMovies).subscribe { [weak self] responseServer in
            do{
                let decodeData = try JSONDecoder().decode(MovieCagegoriesModel.self, from: responseServer.data)
                self?.downloadDataDelegate?.onDownloadDataCorrect(categories: decodeData.listAllCagegories)
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
