//
//  DownloadDataFromView.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation
import Moya

protocol DownloadDataFromView: AnyObject {
    func onDownloadDataCorrect (movies: [MoviesData])
    func onDownloadDataCorrect (categories: [MovieCagegory])
    func onDownloadDataError (errorReceived: Error)
}

//MARK: - OPTIONAL METHODS
extension DownloadDataFromView {
    func onDownloadDataCorrect (movies: [MoviesData]) {}
    func onDownloadDataCorrect (categories: [MovieCagegory]) {}
    func onDownloadDataError (errorReceived: Error) {}
}
