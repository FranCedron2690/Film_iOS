//
//  FilmsService.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import Foundation
import Moya

enum MoviesService {

    static let baseAdress = "https://api.themoviedb.org/3"
    static let baseAddresImages = "https://image.tmdb.org/t/p/original"
    static let APIKey = "95a5cde9017f91bec02d21f143a78711"

    case getAllCategories
    case getPopularMovies
    case getMoviesByCategory (idCategory: Int)
    case getMovieByID (idMovie: Int)
    case getMovieImagePoster
}

extension MoviesService: TargetType {
    var baseURL: URL {
        switch self {
        case .getAllCategories,
            .getPopularMovies,
            .getMoviesByCategory,
            .getMovieByID:
            return URL(string: MoviesService.baseAdress)!
        case .getMovieImagePoster:
            return URL(string: MoviesService.baseAddresImages)!
        }
    }

    var path: String {
        switch self {
        case .getAllCategories:
            return "/genre/movie/list"
        case .getPopularMovies:
            return "/movie/popular"
        case .getMoviesByCategory:
            return "discover/movie"
        case .getMovieByID(let movieID):
            return "/movie/\(movieID)"
        case .getMovieImagePoster:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAllCategories,
            .getPopularMovies,
            .getMoviesByCategory,
            .getMovieByID,
            .getMovieImagePoster:
            return Moya.Method.get
        }
    }

    var task: Task {
        var parametersURL = [String: Any]()
        parametersURL["api_key"] = MoviesService.APIKey

        switch self {
        case .getAllCategories,
                .getPopularMovies:
            print("")
        case .getMoviesByCategory(let idCategory):
            parametersURL["with_genres"] = idCategory
        case .getMovieByID:
            print("")
        case .getMovieImagePoster:
            print("")
        }

        return .requestParameters(parameters: parametersURL, encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        // si no ponemos este header por defecto, devolverá un error
        return ["application/json": "Content-Type"]
    }
}
