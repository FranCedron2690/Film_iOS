//
//  PopularMoviesViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import Foundation
import RxSwift

class PopularMoviesViewModel {
    
    private let disposeBag = DisposeBag()
    
    func downloadPopularListMovies() {
        NetworkManager.instance.makeRequest(endpointToExecute: .getPopularMovies).subscribe { [weak self] response in
            do {
                let decodeData = try JSONDecoder().decode(MovieListModel.self, from: response.data)
//                self?.popularMovies = decodeData.results
//                self?.showTable(isVisible: true)
//                self?.tableView.reloadData()
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
