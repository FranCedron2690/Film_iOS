//
//  RoundedBoxTextField.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 10/1/22.
//

import UIKit

@IBDesignable
class RoundedBoxTextField: RoundBoxControl {
    
    @IBOutlet weak var textFieldData: UITextField!
    
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
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: textFieldData.frame.height))
        let posYCenterImage = (textFieldData.frame.height - Constants.imageSize) / 2
        
        if isLeft {
            setLeftViewMode(container: container, posYCenterImage: posYCenterImage)
        } else {
            setRightViewMode(container: container, posYCenterImage: posYCenterImage)
        }
    }
    
    override func setSecurityText() {
        textFieldData.isSecureTextEntry = isPassword
    }
    
    override func setPlaceholder() {
        textFieldData.placeholder = placelolder
    }
    
    func setNumericKeyboard() {
        textFieldData.keyboardType = .numberPad
    }
}

extension RoundedBoxTextField {
    func setLeftViewMode (container: UIView, posYCenterImage: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 20, y: posYCenterImage, width: Constants.imageSize, height: Constants.imageSize))
        imageView.contentMode = .scaleAspectFit
        imageView.image = leftIconImage
        container.addSubview(imageView)
        textFieldData.leftView = container
        textFieldData.leftViewMode = .always
    }
    
    func setRightViewMode (container: UIView, posYCenterImage: CGFloat) {
        let buttonImage = UIButton(frame: CGRect(x: 20, y: posYCenterImage, width: Constants.imageSize, height: Constants.imageSize))
        buttonImage.setImage(secureImageEnabled, for: .normal)
        buttonImage.imageView?.contentMode = .scaleAspectFit
        buttonImage.addTarget(self, action: #selector(onTouchShowSecureText), for: .touchDown)
        container.addSubview(buttonImage)
        textFieldData.rightView = container
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
