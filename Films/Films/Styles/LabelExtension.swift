//
//  labelExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 14/1/22.
//

import Foundation
import UIKit
import RxSwift

extension UILabel: StyleProtocol {
    func applyStyle(style: GenericStyle) {
        if let styleLabel = style as? Styles.Labels {
            self.font = styleLabel.font
        }
    }
}
