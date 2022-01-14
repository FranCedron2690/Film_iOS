//
//  roundBoxControlsExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation

extension RoundBoxControl: StyleProtocol {
    func applyStyle(style: GenericStyle) {
        if let roundBoxStyle = style as? Styles.RoundBoxControls {
            self.layer.cornerRadius = self.frame.height / 2
            self.backgroundColor = roundBoxStyle.BGColor
            if roundBoxStyle.hasShadow {
                self.applyShadow()
            }
        }
    }
}
