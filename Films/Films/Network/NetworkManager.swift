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
    static let shared = NetworkManager()
    private let provider = MoyaProvider<MoviesService>()

    func execute<T: Decodable>(toExecute: MoviesService, onOk: @escaping(T) -> Void, onError: @escaping(NetworkError) -> Void) {
            self.provider.request(toExecute) { [weak self] result in
                switch result {
                case let .success(response):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                        onOk(decodedData)
                    } catch {
                        let networkError = self?.getNetworkError(fromError: error)
                        onError(networkError!)
                    }
                case let .failure(errorReceived):
                    let networkError = self?.getNetworkError(fromError: errorReceived)
                    onError(networkError!)
                }
            }
    }
    private func getNetworkError(fromError: Error) -> NetworkError {
        if let errorMoya = fromError as? MoyaError {
            switch errorMoya {
            case .imageMapping, .jsonMapping, .stringMapping, .objectMapping, .encodableMapping, .requestMapping:
                return NetworkError(description: errorMoya.localizedDescription, type: .networkErrorMapping)
            case .statusCode:
                return NetworkError(description: errorMoya.localizedDescription, type: .networkErrorStatusCode)
            case .underlying:
                return NetworkError(description: errorMoya.localizedDescription, type: .networkErrorUnderlying)
            case .parameterEncoding:
                return NetworkError(description: errorMoya.localizedDescription, type: .networkErrorParameterEncoder)
            }
        } else { // Otros errores que no sea de Moya, que en este caso solo puede ser al decodificar
            return NetworkError(description: fromError.localizedDescription, type: .networkErrorDecodingJson)
        }
    }
}
