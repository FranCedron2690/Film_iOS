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
    typealias Style = Styles.Labels
    func applyStyle(_ style: Style) {
        self.font = style.font
    }
}
