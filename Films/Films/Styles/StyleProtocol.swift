//
//  StyleProtocol.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation

protocol StyleProtocol {
    associatedtype Style: GenericStyle
    func applyStyle(_ style: Style)
}
