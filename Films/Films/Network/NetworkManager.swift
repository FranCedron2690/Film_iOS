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
    
    func makeRequest<T:Decodable> (endpointToExecute: MoviesService, onOk: @escaping(T) -> Void, onError: @escaping(Error) -> Void){
        
        self.provider.request(endpointToExecute) { result in
            switch result {
            case let .success(response):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                    onOk(decodedData)
                }
                catch{
                    onError(error)
                }
            case let .failure(errorReceived):
                onError(errorReceived)
            }
        }
    }
    
    func showNetworkAlert (error: Error) -> UIAlertController {
        let errorInfo = getErrorMessage(error: error)
        let alert = UIAlertController(title: errorInfo.title, message: errorInfo.message, preferredStyle: .alert)
        
        let actionAlert = UIAlertAction(title: "Ok", style: .default) { action in
            
        }
        
        alert.addAction(actionAlert)
        
        return alert
    }
    
    private func getErrorMessage (error: Error) -> (title:String, message:String) {
        var valueReturn = ("valor", "message")
        if let errorMoya = error as? MoyaError {
            switch errorMoya {
            case .imageMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .jsonMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .stringMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .objectMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .encodableMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .statusCode:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .underlying:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .requestMapping:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            case .parameterEncoding:
                valueReturn = ("Error Image Mapping",errorMoya.localizedDescription)
            }
        }
        else {
            valueReturn = ("Other error", error.localizedDescription)
        }
        
        return valueReturn
    }
}
