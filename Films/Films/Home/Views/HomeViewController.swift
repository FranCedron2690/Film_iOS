//
//  HomeViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit
import FirebaseCrashlytics

class HomeViewController: UIViewController {
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var retryButton: UIButton!
    @IBOutlet private weak var errorLoginLabel: UILabel!
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        translateTexts()
        showButtonLogin()
    }

    private func translateTexts () {
        userLabel.text = getStringTranslated(key: "UserText")
        passwordLabel.text = getStringTranslated(key: "PasswordText")
        userTextField.placeholder = getStringTranslated(key: "UserPlaceholderText")
        passwordTextField.placeholder = getStringTranslated(key: "PasswordPlaceholderText")
        loginButton.setTitle(getStringTranslated(key: "LoginButtonText"), for: .normal)
        retryButton.setTitle(getStringTranslated(key: "RetryLoginButtonText"), for: .normal)
    }

    private func getStringTranslated(key: String) -> String {
        return NSLocalizedString(key, tableName: "Localization", bundle: Bundle.self.main, value: "", comment: "")
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
}
