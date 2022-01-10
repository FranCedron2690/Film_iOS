//
//  HomeCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let movieListContainerCoordinator: TabBarCoordinator // MovieListContainerCoordinator
    init(presenter: UINavigationController) {
        self.presenter = presenter
        movieListContainerCoordinator = TabBarCoordinator(presenter: presenter)// MovieListContainerCoordinator(presenter: presenter)
    }
    func start() {
        let view = LoginRegisterViewController(nibName: "LoginRegisterViewController", bundle: Bundle.main) // HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
//        view.viewModel = HomeViewModel(homeDelegate: self)
        presenter.pushViewController(view, animated: true)
    }
}

extension HomeCoordinator: HomeDelegate {
    func onLoginOk() {
        movieListContainerCoordinator.start()
    }
}
