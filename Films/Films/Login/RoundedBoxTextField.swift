//
//  RoundedBoxTextField.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 10/1/22.
//

import UIKit

@IBDesignable
class RoundedBoxTextField: UIView {
    let imageView = UIImageView()
    let textField = UITextField()

        @IBInspectable var iconImage: UIImage = UIImage() {
            didSet {
                setbackImage()
            }
        }
    
        func setbackImage(){
            self.imageView.image = iconImage
            
        }
        
        
        
        @IBInspectable var placelolder: String = String() {
            didSet {
                setPlaceholder()
            }
        }
    
        func setPlaceholder () {
            self.textField.placeholder = placelolder
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func xibSetup() {
        if self.subviews.isEmpty {        // *** WORK AROUND ***
            let view = loadViewFromNib()
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    func commonInit() {
        xibSetup()
    }

//    func createControl() {
//        self.layer.cornerRadius = 25
//        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.lightGray.cgColor
//
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(imageView)
//
//        textField.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(textField)
//
//        // UIImageView constraints
//        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
//        let centerYImageView = imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        let heightImageView = imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize)
//        let widhtImageView = imageView.widthAnchor.constraint(equalToConstant: 40)
//
//        var constraintsImage = [NSLayoutConstraint]()
//        constraintsImage.append(contentsOf: [leadingConstraint, centerYImageView, heightImageView, widhtImageView])
//        NSLayoutConstraint.activate(constraintsImage)
//
//        // UITextField constraints
//        let leadingTextFieldConstraint = textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
//        let trailingTextFieldConstraint = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
//        let centerTextFieldYImageView = textField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        let heightTextField = textField.heightAnchor.constraint(equalToConstant: 40)
//
//        var constraintsTextField = [NSLayoutConstraint]()
//        constraintsTextField.append(contentsOf: [leadingTextFieldConstraint, trailingTextFieldConstraint, centerTextFieldYImageView, heightTextField])
//        NSLayoutConstraint.activate(constraintsTextField)
//    }
//
//    enum Constants {
//        static let imageSize: CGFloat = 40
//    }
}
