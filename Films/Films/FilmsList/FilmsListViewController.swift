//
//  FilmsListViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import UIKit

class FilmsListViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    private var moviesListByCategory = UIView()
    private var popularMovies = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesListByCategory = MovieListViewController().view
        popularMovies = PopularMoviesViewController().view
        
        containerView.addSubview(moviesListByCategory)
        containerView.addSubview(popularMovies)
    }

    @IBAction func onSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            containerView.bringSubviewToFront(moviesListByCategory)
        }
        else {
            containerView.bringSubviewToFront(popularMovies)
        }
    }

}
