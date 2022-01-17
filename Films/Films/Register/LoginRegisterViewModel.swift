//
//  LoginRegisterViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import RxSwift
import RxCocoa

class LoginRegisterViewModel: BaseViewModel {
    
    public let user = BehaviorRelay<String>(value: "")

    private weak var loginRegisterDelegate: LoginRegisterDelegate?

    init (viewDelegate: LoginRegisterDelegate) {
        self.loginRegisterDelegate = viewDelegate
    }
    
    func registerUser() {
//        user.onNext("Holaa")
        print(user.value)
//        loginRegisterDelegate?.goBackToLogin()
    }
    
    func goBackLogin() {
        loginRegisterDelegate?.goBackToLogin()
    }
}
