//
//  MovieTabBarController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 5/1/22.
//

import Foundation
import UIKit

class MovieTabBarController: UITabBarController {

    weak var selectedMovieDelegate: SelectedMovie?

    override func viewDidLoad() {
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let popularViewController = PopularMoviesViewController()
        let tabPopularMovies = UITabBarItem(title: "Popular", image: UIImage(systemName: "heart.circle"), tag: 0)
        popularViewController.viewModel = PopularMoviesViewModel(selectedMovieDelegate: selectedMovieDelegate!)
        popularViewController.tabBarItem = tabPopularMovies

        let listMoviesViewController = MovieListViewController()
        let tabListMovies = UITabBarItem(title: "Categories", image:  UIImage(systemName: "heart"), tag: 1)
        listMoviesViewController.viewModel = MovieListViewModel(selectedMovieDelegate: selectedMovieDelegate!)
        listMoviesViewController.tabBarItem = tabListMovies

        self.viewControllers = [popularViewController, listMoviesViewController]
    }
}

extension MovieTabBarController: UITabBarControllerDelegate {
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print (item.title)
//    }
//
//    override var selectedIndex: Int { // Mark 1
//            didSet {
//                guard let selectedViewController = viewControllers?[selectedIndex] else {
//                    return
//                }
//                selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
//            }
//        }
//
//        override var selectedViewController: UIViewController? { // Mark 2
//            didSet {
//
//                guard let viewControllers = viewControllers else {
//                    return
//                }
//
//                for viewController in viewControllers {
//                    if viewController == selectedViewController {
//                        viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
//                    } else {
//                        viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)], for: .normal)
//                    }
//                }
//            }
//        }
}
