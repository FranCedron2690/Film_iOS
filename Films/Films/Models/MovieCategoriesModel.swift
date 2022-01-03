//
//  MovieCategoriesModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation
import UIKit

// MARK: - MovieCagegoriesModel
struct MovieCagegoriesModel: Codable {
    let listAllCagegories: [MovieCagegory]

    enum CodingKeys: String, CodingKey {
        case listAllCagegories = "genres"
    }
}

// MARK: - MovieCagegory
struct MovieCagegory: Codable {
    var scrollCategoryOffset = CGPoint.zero
    let idCategory: Int
    let nameCategory: String

    enum CodingKeys: String, CodingKey {
        case idCategory = "id"
        case nameCategory = "name"
    }
}
