//
//  RoundedBoxTextFieldProtocol.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 13/1/22.
//

import Foundation
import UIKit

protocol RoundedBoxTextFieldProtocol {
    var secureImageEnabled: UIImage {get set}
    var secureImageDisabled: UIImage {get set}
    var isPassword: Bool {get set}
    var placelolder: String {get set}    
    var numericKeyboard: Bool {get set}
    func setTextEditLateralContainer(isLeft: Bool)
    func setSecurityText()
    func setPlaceholder()
    func setNumericKeyboard()
}
