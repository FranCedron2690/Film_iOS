//
//  NetworkError.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 29/12/21.
//

import Foundation

enum NetworkError: Error {
    case NetworkUnreachable (description:String)
    case DecodingError (description:String)
}
