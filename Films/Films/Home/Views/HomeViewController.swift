//
//  HomeViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorLoginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateTexts ()
        showButtonLogin ()
    }
    
    private func translateTexts () {
        userLabel.text = getStringTranslated (key: "UserText")
        passwordLabel.text = getStringTranslated (key: "PasswordText")
        userTextField.placeholder = getStringTranslated (key: "UserPlaceholderText")
        passwordTextField.placeholder = getStringTranslated (key: "PasswordPlaceholderText")
        loginButton.setTitle(getStringTranslated (key: "LoginButtonText"), for: .normal)
        retryButton.setTitle(getStringTranslated (key: "RetryLoginButtonText"), for: .normal)
    }
    
    private func getStringTranslated (key:String) -> String {
        return NSLocalizedString(key, tableName: "Localization", bundle: Bundle.self.main, value: "", comment: "")
    }
    
    private func showButtonLogin (){
        loginButton.isHidden = false
        retryButton.isHidden = true
        errorLoginLabel.isHidden = true
    }
    
    private func showErrorLogin (){
        loginButton.isHidden = true
        retryButton.isHidden = false
        errorLoginLabel.isHidden = false
    }
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        let movieList = MovieListContainerViewController()//PopularMoviesViewController()
        self.navigationController?.pushViewController(movieList, animated: true)
    }
}
