//
//  ButtonsExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation
import UIKit

extension UIButton: StyleProtocol {
    typealias Style = Styles.Buttons
    func applyStyle(_ style: Style) {
        self.applyGradient(colors: style.gradientColors)
        self.titleLabel?.font = style.font
        self.titleLabel?.textColor = style.colorFont
        if style.hasShadow {
            self.applyShadow()
        }
    }
}
