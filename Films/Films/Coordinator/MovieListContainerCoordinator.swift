//
//  MovieListContainerCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import Foundation
import UIKit

class MovieListContainerCoordinator: Coordinator {
    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let movieListContainer = MovieListContainerViewController(nibName: "MovieListContainerViewController", bundle: Bundle.main)
        movieListContainer.viewModel = MovieListContainterViewModel(view: movieListContainer, selectedMovieDelegate: self)
        presenter.pushViewController(movieListContainer, animated: true)
    }

}

extension MovieListContainerCoordinator: SelectedMovie {
    func onSelectedMovie(idMovie: Int) {
        let movieDetailCoordinator = MovieDetailCoordinator(presenter: presenter, movieId: idMovie)
        movieDetailCoordinator.start()
    }
}
