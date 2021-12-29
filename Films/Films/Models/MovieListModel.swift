//
//  MovieCategoriesModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation
import UIKit

// MARK: - MovieListModel
struct MovieListModel: Codable {
    let results: [MoviesData]    
}

// MARK: - MoviesData
struct MoviesData: Codable {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
