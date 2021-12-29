//
//  MovieListContainterViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 28/12/21.
//

import Foundation
import UIKit

class MovieListContainterViewModel: BaseViewModel {
    
    private weak var selectedMovieDelegate: SelectedMovie?
    weak var view: MovieListContainerViewController?
    
    enum TypesContentViews {
        case PopularMovies
        case MovieList
    }
    
    init (view:MovieListContainerViewController, selectedMovieDelegate: SelectedMovie){
        self.view = view
        self.selectedMovieDelegate = selectedMovieDelegate
    }
    
    private lazy var poularMoviesViewController: PopularMoviesViewController = {
        
        let viewController = PopularMoviesViewController()
        viewController.viewModel = PopularMoviesViewModel(selectedMovieDelegate: selectedMovieDelegate!)
        viewController.view.frame = (view?.containerView.bounds)!
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: view)

        return viewController
    }()

    private lazy var movieListViewController: MovieListViewController = {
        
        let viewController = MovieListViewController()
        viewController.viewModel = MovieListViewModel(selectedMovieDelegate: selectedMovieDelegate!)
        viewController.view.frame = (view?.containerView.bounds)!
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: view)

        return viewController
    }()
    
    func showView (viewType:TypesContentViews){
        switch viewType {
        case .PopularMovies:
            removeViewController(asChildViewController: movieListViewController)
            addViewController(asChildViewController: poularMoviesViewController)
        case .MovieList:
            removeViewController(asChildViewController: poularMoviesViewController)
            addViewController(asChildViewController: movieListViewController)
        }
    }    
    
    private func addViewController (asChildViewController viewController: UIViewController) {
        view?.addChild(viewController)//le digo a este viewController en el que estamos que va a tener el siguiente hijo
        view?.containerView.addSubview(viewController.view)//pinto la vista del UIController que quiero, dentro de la capa en la que quiero que pinte
//
        // Notify Child View Controller
        viewController.didMove(toParent: view)
    }
    
    private func removeViewController(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
