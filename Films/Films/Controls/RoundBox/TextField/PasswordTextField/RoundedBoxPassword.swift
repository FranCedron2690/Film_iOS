//
//  RoundedBoxPassword.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 17/1/22.
//

import Foundation
import UIKit

class RoundedBoxPassword : RoundedBoxTextField, RoundedBoxPasswordProtocol {
    
    let secureImageEnabled: UIImage = UIImage(systemName: "eye.fill")!
    let secureImageDisabled: UIImage = UIImage(systemName: "eye.slash.fill")!
    
    @IBInspectable var isPassword: Bool = Bool() {
        didSet {
            setSecurityText()
        }
    }
    
    func setSecurityText() {
        textFieldData.isSecureTextEntry = isPassword
        
        if isPassword {
            configureButtonVisibilityPassword()
        }
    }
    
    func configureButtonVisibilityPassword() {
        let imageButton = UIButton()
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.setImage(secureImageEnabled, for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.addTarget(self, action: #selector(onTouchShowSecureText), for: .touchDown)
        textFieldData.rightView = imageButton
        
        NSLayoutConstraint.activate(addConstraintsTextFieldRightContent(view: imageButton))
        
        textFieldData.rightViewMode = .always
    }
    
    @objc func onTouchShowSecureText() {
        isPassword = !isPassword
        
        if let buttonImage = textFieldData.rightView as? UIButton {
            let image = isPassword ? secureImageEnabled : secureImageDisabled
            buttonImage.setImage(image, for: .normal)
            textFieldData.rightView = buttonImage
        }
    }
}
