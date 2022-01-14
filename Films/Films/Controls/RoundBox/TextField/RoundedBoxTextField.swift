//
//  RoundedBoxTextField.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 10/1/22.
//

import UIKit

@IBDesignable
class RoundedBoxTextField: RoundBoxControl, RoundedBoxTextFieldProtocol {
    
    @IBOutlet weak var textFieldData: UITextField!
    
    @IBInspectable var secureImageEnabled: UIImage = UIImage() {
        didSet {
            setTextEditLateralContainer(isLeft: false)
        }
    }
    
    @IBInspectable var secureImageDisabled: UIImage = UIImage()
    
    @IBInspectable var isPassword: Bool = Bool() {
        didSet {
            setSecurityText()
        }
    }
    
    @IBInspectable var placelolder: String = String() {
        didSet {
            setPlaceholder()
        }
    }
    
    @IBInspectable var numericKeyboard : Bool = false {
        didSet {
            if numericKeyboard {
                setNumericKeyboard()
            }
        }
    }
    
    override func commonInit() {
        nibName = String(describing: type(of: self))
        xibSetup()

        textFieldData.delegate = self
    }

    override func setTextEditLateralContainer(isLeft: Bool) {
        if isLeft {
            setLeftViewMode()
        } else {
            setRightViewMode()
        }
    }
    
    func setSecurityText() {
        textFieldData.isSecureTextEntry = isPassword
    }
    
    func setPlaceholder() {
        textFieldData.placeholder = placelolder
    }
    
    func setNumericKeyboard() {
        textFieldData.keyboardType = .numberPad
    }
}

extension RoundedBoxTextField {
    func setLeftViewMode () {
        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = leftIconImage
        textFieldData.leftView = imageView
        addConstraintsView(viewToAddContraints: imageView, viewReference: textFieldData.leftView!)
        textFieldData.leftViewMode = .always
    }
    
    func setRightViewMode () {
        let buttonImage = UIButton()
//        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.setImage(secureImageEnabled, for: .normal)
        buttonImage.imageView?.contentMode = .scaleAspectFit
        buttonImage.addTarget(self, action: #selector(onTouchShowSecureText), for: .touchDown)
        textFieldData.rightView = buttonImage
        addConstraintsView(viewToAddContraints: buttonImage, viewReference: textFieldData.rightView!)
        textFieldData.rightViewMode = .always
    }
    
    @objc func onTouchShowSecureText() {
        isPassword = !isPassword
        
        if let container = textFieldData.rightView, let buttonImage = container.subviews[0] as? UIButton {
            let image = isPassword ? secureImageEnabled : secureImageDisabled
            buttonImage.setImage(image, for: .normal)
            container.addSubview(buttonImage)
            textFieldData.rightView = container
        }
    }
}

extension RoundedBoxTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
