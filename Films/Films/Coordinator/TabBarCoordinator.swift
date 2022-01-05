//
//  TabBarCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 5/1/22.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {

    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let movieListContainer = MovieTabBarController()
        movieListContainer.selectedMovieDelegate = self
        presenter.pushViewController(movieListContainer, animated: true)
    }
}

extension TabBarCoordinator: SelectedMovie {
    func onSelectedMovie(idMovie: Int) {
        let movieDetailCoordinator = MovieDetailCoordinator(presenter: presenter, movieId: idMovie)
        movieDetailCoordinator.start()
    }
}
