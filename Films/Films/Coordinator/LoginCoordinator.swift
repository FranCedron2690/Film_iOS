//
//  HomeCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let movieListContainerCoordinator: TabBarCoordinator
    private let loginRegisterContainerCoordinator: LoginRegisterCoordinator
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        movieListContainerCoordinator = TabBarCoordinator(presenter: presenter)
        loginRegisterContainerCoordinator = LoginRegisterCoordinator(presenter: presenter)
    }
    
    func start() {
        let view = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
        view.viewModel = LoginViewModel(viewDelegate: self)
        presenter.pushViewController(view, animated: true)
    }
}

extension LoginCoordinator: LoginViewDelegate {
    func onSignUpClick() {
        loginRegisterContainerCoordinator.start()
    }
    
    func onLoginOk() {
        movieListContainerCoordinator.start()
    }
}
