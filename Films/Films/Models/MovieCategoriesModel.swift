//
//  MovieCategoriesModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation

// MARK: - MovieCagegoriesModel
struct MovieCagegoriesModel: Codable {
    let listAllCagegories: [MovieCagegory]
    
    enum CodingKeys: String, CodingKey {
        case listAllCagegories = "genres"
    }
}

// MARK: - MovieCagegory
struct MovieCagegory: Codable {
    let id: Int
    let name: String
}

