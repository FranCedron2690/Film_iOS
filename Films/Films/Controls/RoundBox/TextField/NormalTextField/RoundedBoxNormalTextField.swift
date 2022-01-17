//
//  RoundedBoxText.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 17/1/22.
//

import Foundation

class RoundedBoxNormalTextField: RoundedBoxTextField, RoundedBoxNormalTextFieldProtocol {
    @IBInspectable var numericKeyboard : Bool = false {
        didSet {
            if numericKeyboard {
                setNumericKeyboard()
            }
        }
    }
    
    func setNumericKeyboard() {
        textFieldData.keyboardType = .numberPad
    }
}
