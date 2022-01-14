//
//  LoginRegisterViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 7/1/22.
//

import UIKit
import RxSwift

class LoginRegisterViewController: BaseViewController {
    
    @IBOutlet weak var singUpTitleLabel: UILabel!
    @IBOutlet weak var userTextField: RoundedBoxTextField!
    @IBOutlet weak var mailTextField: RoundedBoxTextField!
    @IBOutlet weak var passwordTextField: RoundedBoxTextField!
    @IBOutlet weak var codePostalRoundBoxControl: RoundedBoxTextField!
    @IBOutlet weak var dateBornRoundBoxControl: RoundedBoxDate!
    @IBOutlet weak var aceptedDataSwitch: UISwitch!
    @IBOutlet weak var textInfoAgreeTerms: UILabel!
    @IBOutlet weak var errorInfoLabel: UILabel!
    @IBOutlet weak var existAccountLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var singInButton: UIButton!
    
    var viewModel: LoginRegisterViewModel?
    
    // Provisional
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To close Keyboard when tap out of textfields!!
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
                
//        viewModel?.user
//            .observe(on: MainScheduler.instance)
//            .bind(to: self.userTextField.textFieldData.rx.text)
//            .disposed(by: disposeBag)
//        
//        userTextField.textFieldData.rx.text.observeOn(MainScheduler.instance).bind(to: viewModel?.user).disposed(by: disposeBag)
                
        translateTexts()
        applyStyles()
    }
    
    @IBAction func onCreateAccountClicked(_ sender: UIButton) {
        viewModel?.registerUser()
        
//        guard let userName = userTextField.textFieldData.text, !userName.isEmpty else {
//            let errorMessage = LocalizedConstants.emtpyUserError.localized()
//            showErrorMessage(errorMessage)
//            return
//        }
//        guard let mail = mailTextField.textFieldData.text, !mail.isEmpty else {
//            let errorMessage = LocalizedConstants.emtpyUserError.localized()
//            showErrorMessage(errorMessage)
//            return
//        }
//        guard let dateBorn = dateBornRoundBoxControl.dateString, !dateBorn.isEmpty else {
//            let errorMessage = LocalizedConstants.emtpyBornDateError.localized()
//            showErrorMessage(errorMessage)
//            return
//        }
//        guard let postalCode = codePostalRoundBoxControl.textFieldData.text, !postalCode.isEmpty else {
//            let errorMessage = LocalizedConstants.emtpyPostalCodeError.localized()
//            showErrorMessage(errorMessage)
//            return
//        }
//        guard let password = passwordTextField.textFieldData.text, !password.isEmpty else {
//            let errorMessage = LocalizedConstants.emtpyPasswordError.localized()
//            showErrorMessage(errorMessage)
//            return
//        }
//
//        let emailPattern = #"^\S+@\S+\.\S+$"#
//
//        let result = mail.range(
//            of: emailPattern,
//            options: .regularExpression
//        )
//
//        if (result != nil) {
//            print("Mail valido!!")
//        } else {
//            print("Mail NO valido!!")
//        }
//
//        if aceptedDataSwitch.isOn {
//            viewModel?.registerUser()
//        } else {
//            let errorMessage = LocalizedConstants.noDataAcceptError.localized()
//            showErrorMessage(errorMessage)
//        }
    }
    
    func showErrorMessage(_ message: String) {
        errorInfoLabel.isHidden = false
        errorInfoLabel.text = message
    }
    
    @IBAction func onSignInClicked(_ sender: UIButton) {
        viewModel?.goBackLogin()
    }
}

extension LoginRegisterViewController: UIViewControllerProtocol {
    func translateTexts() {
        singUpTitleLabel.text = LocalizedConstants.LoginRegister.signUpTitleText.localized()
        userTextField.placelolder = LocalizedConstants.LoginRegister.userPlaceholder.localized()
        mailTextField.placelolder = LocalizedConstants.LoginRegister.mailPlaceholder.localized()
        codePostalRoundBoxControl.placelolder = LocalizedConstants.LoginRegister.codePostalPlaceholder.localized()
        dateBornRoundBoxControl.textDescription = LocalizedConstants.LoginRegister.bornPlaceholder.localized()
        passwordTextField.placelolder = LocalizedConstants.LoginRegister.passwordPlaceholder.localized()
        textInfoAgreeTerms.text = LocalizedConstants.LoginRegister.termsAndConditionsText.localized()
        existAccountLabel.text = LocalizedConstants.LoginRegister.textHasAnAccount.localized()
        createAccountButton.setTitle(LocalizedConstants.LoginRegister.createButtonText.localized() , for: .normal)
        singInButton.setTitle(LocalizedConstants.LoginRegister.signInButtonText.localized() , for: .normal)
    }
    
    func applyStyles() {
        singUpTitleLabel.applyStyle(style: Styles.Labels.titleLabel)
        textInfoAgreeTerms.applyStyle(style: Styles.Labels.thinLabelInfo)
        errorInfoLabel.applyStyle(style: Styles.Labels.errorLabel)
        existAccountLabel.applyStyle(style: Styles.Labels.thinLabelInfo)
                
        createAccountButton.applyStyle(style: Styles.Buttons.mainButton)
        
        userTextField.applyStyle(style: Styles.RoundBoxControls.textEdit)
        mailTextField.applyStyle(style: Styles.RoundBoxControls.textEdit)
        passwordTextField.applyStyle(style: Styles.RoundBoxControls.textEdit)
        codePostalRoundBoxControl.applyStyle(style: Styles.RoundBoxControls.textEdit)
        dateBornRoundBoxControl.applyStyle(style: Styles.RoundBoxControls.datePicker)
    }
}
