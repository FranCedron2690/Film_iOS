//
//  RoundedBoxTextField.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 10/1/22.
//

import UIKit

@IBDesignable
class RoundedBoxTextField: UIView {
    
    @IBOutlet weak var textField: UITextField!
    
    enum Constants {
        static let cornerRadius: CGFloat = 25
        static let borderWidth: CGFloat = 2
        static let borderColor = UIColor.tintColor.cgColor
        static let imageSize: CGFloat = 25
    }
    
    @IBInspectable var leftIconImage: UIImage = UIImage() {
        didSet {
            setTextEditLateralContainer(isLeft: true)
        }
    }
    
    @IBInspectable var secureImageEnabled: UIImage = UIImage() {
        didSet {
            setTextEditLateralContainer(isLeft: false)
        }
    }
    
    @IBInspectable var secureImageDisabled: UIImage = UIImage()
    
    @IBInspectable var isSecure: Bool = Bool() {
        didSet {
            setSecurityText()
        }
    }
    
    @IBInspectable var placelolder: String = String() {
        didSet {
            setPlaceholder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return nil
        }
    }
    
    func commonInit() {
        xibSetup()
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = Constants.borderColor
    }
    
    func xibSetup() {
        if self.subviews.isEmpty {
            if let view = loadViewFromNib() {
                view.frame = bounds
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(view)
            }
        }
    }
}

extension RoundedBoxTextField {
    func setTextEditLateralContainer(isLeft: Bool) {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: textField.frame.height))
        let posYCenterImage = (textField.frame.height - Constants.imageSize) / 2
        
        if isLeft {
            setLeftViewMode(container: container, posYCenterImage: posYCenterImage)
        } else {
            setRightViewMode(container: container, posYCenterImage: posYCenterImage)
        }
    }
    
    func setLeftViewMode (container: UIView, posYCenterImage: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 20, y: posYCenterImage, width: Constants.imageSize, height: Constants.imageSize))
        imageView.contentMode = .scaleAspectFit
        imageView.image = leftIconImage
        container.addSubview(imageView)
        textField.leftView = container
        textField.leftViewMode = .always
    }
    
    func setRightViewMode (container: UIView, posYCenterImage: CGFloat) {
        let buttonImage = UIButton(frame: CGRect(x: 20, y: posYCenterImage, width: Constants.imageSize, height: Constants.imageSize))
        buttonImage.setImage(secureImageEnabled, for: .normal)
        buttonImage.imageView?.contentMode = .scaleAspectFit
        buttonImage.addTarget(self, action: #selector(onTouchShowSecureText), for: .touchDown)
        container.addSubview(buttonImage)
        textField.rightView = container
        textField.rightViewMode = .always
    }
    
    func setSecurityText() {
        textField.isSecureTextEntry = isSecure
    }
    
    func setPlaceholder() {
        textField.placeholder = placelolder
    }
    
    @objc func onTouchShowSecureText() {
        isSecure = !isSecure
        
        if let container = textField.rightView, let buttonImage = container.subviews[0] as? UIButton {
            let image = isSecure ? secureImageEnabled : secureImageDisabled
            buttonImage.setImage(image, for: .normal)
            container.addSubview(buttonImage)
            textField.rightView = container
        }
    }
}
