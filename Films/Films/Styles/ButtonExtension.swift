//
//  ButtonsExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation
import UIKit

extension UIButton: StyleProtocol {
    func applyStyle(style: GenericStyle) {
        if let buttonStyle = style as? Styles.Buttons {
            self.applyGradient(colors: buttonStyle.gradientColors)
            self.titleLabel?.font = buttonStyle.font
            self.titleLabel?.textColor = buttonStyle.colorFont
            if buttonStyle.hasShadow {
                self.applyShadow()
            }
        }
    }
}
