//
//  LoginRegisterViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 7/1/22.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To close Keyboard when tap out of textfields!!
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
                
        translateTexts()
        applyStyles()
    }
    
    @IBAction func onCreateAccountClicked(_ sender: UIButton) {
        guard let userName = userTextField.textFieldData.text, !userName.isEmpty else {
            let errorMessage = getStringTranslated(key: "registerEmtpyUserError")
            showErrorMessage(errorMessage)
            return
        }
        guard let mail = mailTextField.textFieldData.text, !mail.isEmpty else {
            let errorMessage = getStringTranslated(key: "registerEmtpyMailError")
            showErrorMessage(errorMessage)
            return
        }
        guard let dateBorn = dateBornRoundBoxControl.dateString, !dateBorn.isEmpty else {
            let errorMessage = getStringTranslated(key: "registerEmtpyBornDateError")
            showErrorMessage(errorMessage)
            return
        }
        guard let postalCode = codePostalRoundBoxControl.textFieldData.text, !postalCode.isEmpty else {
            let errorMessage = getStringTranslated(key: "registerEmtpyPostalCodeError")
            showErrorMessage(errorMessage)
            return
        }
        guard let password = passwordTextField.textFieldData.text, !password.isEmpty else {
            let errorMessage = getStringTranslated(key: "registerEmtpyPasswordError")
            showErrorMessage(errorMessage)
            return
        }
        
        let emailPattern = #"^\S+@\S+\.\S+$"#

        let result = mail.range(
            of: emailPattern,
            options: .regularExpression
        )

        if (result != nil) {
            print("Mail valido!!")
        } else {
            print("Mail NO valido!!")
        }
        
        if aceptedDataSwitch.isOn {
            viewModel?.registerUser()
        } else {
            let errorMessage = getStringTranslated(key: "registerNoDataAcceptError")
            showErrorMessage(errorMessage)
        }
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
        let signInText = getStringTranslated(key: "registerSignUpText")
        let userPlaceholder = getStringTranslated(key: "UserPlaceholderText")
        let mailPlaceholder = getStringTranslated(key: "MailPlaceholderText")
        let codePostalPlaceholder = getStringTranslated(key: "CodePostalPlaceholderText")
        let bornPlaceholder = getStringTranslated(key: "bornedPlaceholderText")
        let passwordPlaceholder = getStringTranslated(key: "PasswordPlaceholderText")
        let termsAndConditionsText = getStringTranslated(key: "registerTextReadAgreeeTerms")
        let textHasAnAccount = getStringTranslated(key: "registerHasAnAccount")
        let createButtonText = getStringTranslated(key: "CreateAccountButtonText")
        let signInButtonText = getStringTranslated(key: "registerSignIn")
        
        singUpTitleLabel.text = signInText
        userTextField.placelolder = userPlaceholder
        mailTextField.placelolder = mailPlaceholder
        codePostalRoundBoxControl.placelolder = codePostalPlaceholder
        dateBornRoundBoxControl.placelolder = bornPlaceholder
        passwordTextField.placelolder = passwordPlaceholder
        textInfoAgreeTerms.text = termsAndConditionsText
        existAccountLabel.text = textHasAnAccount
        createAccountButton.setTitle(createButtonText, for: .normal)
        singInButton.setTitle(signInButtonText, for: .normal)
    }
    
    func applyStyles() {
        Styles.Labels.titleLabel.style(label: singUpTitleLabel)
        Styles.Labels.thinLabelInfo.style(label: textInfoAgreeTerms)
        Styles.Labels.errorLabel.style(label: errorInfoLabel)
        Styles.Labels.thinLabelInfo.style(label: existAccountLabel)
        Styles.Buttons.mainButton.style(button: createAccountButton)
        Styles.RoundBoxControls.textEdit.style(roundBoxControl: userTextField)
        Styles.RoundBoxControls.textEdit.style(roundBoxControl: mailTextField)
        Styles.RoundBoxControls.textEdit.style(roundBoxControl: passwordTextField)
        Styles.RoundBoxControls.textEdit.style(roundBoxControl: codePostalRoundBoxControl)
        Styles.RoundBoxControls.datePicker.style(roundBoxControl: dateBornRoundBoxControl)
    }
}
