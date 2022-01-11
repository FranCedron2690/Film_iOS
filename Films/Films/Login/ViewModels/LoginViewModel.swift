//
//  HomeViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 28/12/21.
//

import Foundation

class LoginViewModel: BaseViewModel {
    private weak var loginViewDelegate: LoginViewDelegate?

    init (viewDelegate: LoginViewDelegate) {
        self.loginViewDelegate = viewDelegate
    }

    func goToMovies () {
        loginViewDelegate?.onLoginOk()
    }
    
    func goToRegister () {
        loginViewDelegate?.onSignUpClick()
    }
}
