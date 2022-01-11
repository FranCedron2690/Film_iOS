//
//  LoginRegisterViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation

class LoginRegisterViewModel: BaseViewModel {
    
    private weak var loginRegisterDelegate: LoginRegisterDelegate?

    init (viewDelegate: LoginRegisterDelegate) {
        self.loginRegisterDelegate = viewDelegate
    }
    
    func registerUser() {
        print("Usuario registrado correctamente!!")
        loginRegisterDelegate?.goBackToLogin()
    }
    
    func goBackLogin() {
        loginRegisterDelegate?.goBackToLogin()
    }
}
