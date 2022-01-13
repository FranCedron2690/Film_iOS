//
//  HomeViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit
import FirebaseCrashlytics

class LoginViewController: UIViewController {
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var retryButton: UIButton!
    @IBOutlet private weak var errorLoginLabel: UILabel!
    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        translateTexts()
        applyStyles()
        showButtonLogin()
    }
    
    private func showButtonLogin () {
        loginButton.isHidden = false
        retryButton.isHidden = true
        errorLoginLabel.isHidden = true
    }

    private func showErrorLogin () {
        loginButton.isHidden = true
        retryButton.isHidden = false
        errorLoginLabel.isHidden = false
    }

    @IBAction private func onLoginClicked(_ sender: UIButton) {
        viewModel?.goToMovies()
    }
    
    @IBAction func onSignUpClicked(_ sender: Any) {
        viewModel?.goToRegister()
    }
}

extension LoginViewController: UIViewControllerProtocol {
    func translateTexts () {
        userLabel.text = LocalizedConstants.Login.userLabel.localized()
        passwordLabel.text = LocalizedConstants.Login.passwordLabel.localized()
        userTextField.placeholder = LocalizedConstants.Login.userPlaceholder.localized()
        passwordTextField.placeholder = LocalizedConstants.Login.passwordPlaceholderText.localized()
        loginButton.setTitle(LocalizedConstants.Login.loginButtonText.localized(), for: .normal)
        retryButton.setTitle(LocalizedConstants.Login.retryLoginButtonText.localized(), for: .normal)
    }

    func applyStyles() {
    }
}
