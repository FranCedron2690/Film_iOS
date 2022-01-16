//
//  RoundedBoxTextField.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 10/1/22.
//

import UIKit

@IBDesignable
class RoundedBoxTextField: RoundBoxControl, RoundedBoxTextFieldProtocol {
    
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textFieldData: UITextField!
    
    @IBInspectable var secureImageEnabled: UIImage = UIImage() {
        didSet {
            setRightImage()
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
        
        addAllConstraints()

        textFieldData.delegate = self
    }

    override func setLeftImage() {
        imageLeft.image = leftIconImage
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
    func setRightImage () {
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
        
        if let container = textFieldData.rightView, let buttonImage = container.subviews[0] as? UIButton {
            let image = isPassword ? secureImageEnabled : secureImageDisabled
            buttonImage.setImage(image, for: .normal)
            container.addSubview(buttonImage)
            textFieldData.rightView = container
        }
    }
}

// MARK: - Constraints
extension RoundedBoxTextField {
    func addAllConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: addImageLftConstraints(viewToAddContraints: imageLeft, viewReference: contentView))
        constraints.append(contentsOf: addContentConstraints(viewToAddContraints: contentView, viewReference: imageLeft))
        constraints.append(contentsOf: addConstraintsTextFieldContent())
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addConstraintsTextFieldContent () -> [NSLayoutConstraint] {
        textFieldData.translatesAutoresizingMaskIntoConstraints = false
        let trailingConstraint = textFieldData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        let leadingConstraint = textFieldData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        let topConstraint = textFieldData.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let bottomConstraint = textFieldData.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        
        return [trailingConstraint, leadingConstraint, topConstraint, bottomConstraint ]
    }
    
    func addConstraintsTextFieldRightContent (view: UIButton) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        let rightView = textFieldData.rightView!
        let centerYConstraint = view.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
        let centerXConstraint = view.centerXAnchor.constraint(equalTo: rightView.centerXAnchor)
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: ConstantsConstraints.imageSize)
        let widhtConstraint = view.widthAnchor.constraint(equalToConstant: ConstantsConstraints.imageSize)
        
        return [centerYConstraint, centerXConstraint, heightConstraint, widhtConstraint]
    }
}

extension RoundedBoxTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
