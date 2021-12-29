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
    var scrollCategoryOffset = CGPoint.zero//var interna
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

