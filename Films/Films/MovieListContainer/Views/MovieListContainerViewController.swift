//
//  FilmsListViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import UIKit

class MovieListContainerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    private lazy var poularMoviesViewController: PopularMoviesViewController = {
        
        let viewController = PopularMoviesViewController()
        viewController.view.frame = self.containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)

        return viewController
    }()

    private lazy var movieListViewController: MovieListViewController = {
        
        let viewController = MovieListViewController()
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)

        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        add(asChildViewController: poularMoviesViewController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func onSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            remove(asChildViewController: poularMoviesViewController)
            add(asChildViewController: movieListViewController)
        } else {
            remove(asChildViewController: movieListViewController)
            add(asChildViewController: poularMoviesViewController)
        }
    }
    
    private func add (asChildViewController viewController: UIViewController) {
        addChild(viewController)//le digo a este viewController en el que estamos que va a tener el siguiente hijo
        containerView.addSubview(viewController.view)//pinto la vista del UIController que quiero, dentro de la capa en la que quiero que pinte
//
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
}
