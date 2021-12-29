//
//  MovieDetailCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import UIKit

class MovieDetailCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let movieID: Int
        
    init(presenter: UINavigationController, movieId: Int) {
        self.presenter = presenter
        self.movieID = movieId
    }
    
    func start() {
        let movieDetailView = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: Bundle.main)
        movieDetailView.movieID = self.movieID
        movieDetailView.viewModel = MovieDetailViewModel()
        
        print (presenter.viewControllers)
        
        presenter.pushViewController(movieDetailView, animated: true)
    }
}

extension MovieDetailCoordinator: AlertToCoordinator {
    func showAlert(_ alert: UIAlertController) {
        presenter.present(alert, animated: true, completion: nil)
    }
}
