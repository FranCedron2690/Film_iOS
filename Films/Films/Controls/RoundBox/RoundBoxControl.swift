//
//  RoundBoxControl.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

@IBDesignable
class RoundBoxControl: CustomControl {
    enum Constants {
        static let cornerRadius: CGFloat = 25
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
    
    func setTextEditLateralContainer(isLeft: Bool) {
        
    }
    
    func setSecurityText() {
        
    }
    
    func setPlaceholder() {
        
    }
}
