//
//  FilmsListViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import UIKit

class MovieListContainerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    var viewModel: MovieListContainterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.showView(viewType: .popularMovies, isFirstDefaultView: true)
    }

    override func viewWillDisappear(_ animated: Bool) {

    }

    @IBAction func onSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.showView(viewType: .movieList)
        } else {
            viewModel?.showView(viewType: .popularMovies)
        }
    }
}
