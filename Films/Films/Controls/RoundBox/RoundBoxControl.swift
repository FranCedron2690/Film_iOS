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
}
