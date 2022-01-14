//
//  RoundBoxControl.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

@IBDesignable
class RoundBoxControl: CustomControl, RoundBoxControlProtocol {
    
    enum Constants {
        static let cornerRadius: CGFloat = 25
        static let imageSize: CGFloat = 25
    }

    @IBInspectable var leftIconImage: UIImage = UIImage() {
        didSet {
            do {
                try setTextEditLateralContainer(isLeft: true)
            } catch {}
        }
    }

    func setTextEditLateralContainer(isLeft: Bool) throws {
        fatalError("Sobreescribe este método en el control final para que asigne la imagen!!")
    }
    
    func addConstraintsView (viewToAddContraints: UIView, viewReference: UIView) {
        viewToAddContraints.translatesAutoresizingMaskIntoConstraints = false
        let centerYImageView = viewToAddContraints.centerYAnchor.constraint(equalTo: viewReference.centerYAnchor)
        let centerXImageView = viewToAddContraints.centerXAnchor.constraint(equalTo: viewReference.centerXAnchor)
        let heightImageView = viewToAddContraints.heightAnchor.constraint(equalToConstant: 25)
        let widhtImageView = viewToAddContraints.widthAnchor.constraint(equalToConstant: 55)
        
        var constraintsImage = [NSLayoutConstraint]()
        constraintsImage.append(contentsOf: [centerYImageView, centerXImageView, heightImageView, widhtImageView])
        NSLayoutConstraint.activate(constraintsImage)
    }
}
