//
//  LoginRegisterCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

class LoginRegisterCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let view = LoginRegisterViewController(nibName: "LoginRegisterViewController", bundle: Bundle.main)
        view.viewModel = LoginRegisterViewModel(viewDelegate: self)
        presenter.pushViewController(view, animated: true)
    }
}

extension LoginRegisterCoordinator: LoginRegisterDelegate {
    func goBackToLogin() {
        presenter.popViewController(animated: true)
    }
}
