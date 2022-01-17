//
//  roundBoxControlsExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation

extension RoundBoxControl: StyleProtocol {
    typealias Style = Styles.RoundBoxControls
    func applyStyle(_ style: Style) {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = style.BGColor
        if style.hasShadow {
            self.applyShadow()
        }
    }
}
