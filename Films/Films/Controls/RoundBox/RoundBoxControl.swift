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
    
    func setTextEditLateralContainer(isLeft: Bool) {
        
    }
}
