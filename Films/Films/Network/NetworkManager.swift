//
//  NetworkManager.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation
import Moya
import RxSwift
import Alamofire
import AlamofireImage

class NetworkManager {
    
    private init() {}
    
    static let instance = NetworkManager()
    
    private let provider = MoyaProvider<MoviesService>()
    
    func makeRequest (endpointToExecute: MoviesService) -> Observable<Response>{
                
        return Observable.create { observer in
            
            self.provider.request(endpointToExecute) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(errorReceived):
                    observer.onError(errorReceived)
                }
            }
            
            //Para librerar la memoria, le pasamos un objeto Disposable (si no seguirá escuchando en memoria)
            return Disposables.create{
            }
        }
    }
}
