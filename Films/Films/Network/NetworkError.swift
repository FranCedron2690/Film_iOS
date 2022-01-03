//
//  NetworkError.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 29/12/21.
//

import Foundation

struct NetworkError: Error {

    let description: String

    let type: ErrorType

    enum ErrorType {
        case networkErrorUnreachable
        case networkErrorMapping
        case networkErrorStatusCode
        case networkErrorParameterEncoder
        case networkErrorUnderlying
        case networkErrorDecodingJson
    }
}
