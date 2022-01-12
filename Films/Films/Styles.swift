//
//  Styles.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

enum Styles {
    
    enum ColorGradients {
        case mainButtonGradient
        
        func getColorsGradient() -> [CGColor] {
            switch self {
            case .mainButtonGradient:
                return [UIColor.orange.cgColor, UIColor.tintColor.cgColor]
            }
        }
    }
    
    enum Labels {
        case titleLabel
        case normalLabel
        case thinLabelInfo
        case errorLabel
        
        func style(label: UILabel) {
            switch self {
            case .titleLabel:
                label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
            case .normalLabel:
                label.font = UIFont.systemFont(ofSize: 17.0)
            case .thinLabelInfo:
                label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
            case .errorLabel:
                label.font = UIFont.systemFont(ofSize: 17.0)
                label.textColor = UIColor.red
            }
        }
    }
    
    enum RoundBoxControls {
        case textEdit
        case datePicker
        
        func style(roundBoxControl: RoundBoxControl) {
            roundBoxControl.layer.cornerRadius = roundBoxControl.frame.height / 2
            roundBoxControl.backgroundColor = .white
            roundBoxControl.applyShadow()
//            switch self {
//            case .textEdit:
//                if let textEditRoundBoxControl = roundBoxControl as? RoundedBoxTextField {
//                    
//                }
//            case .datePicker:
//                if let datePickerRoundBoxControl = roundBoxControl as? RoundedBoxDate {
//                    
//                }
//            }
        }
    }
    
    enum Buttons {
        case mainButton
        
        func style(button: UIButton) {
            switch self {
            case .mainButton:
                let gradientColors = Styles.ColorGradients.mainButtonGradient.getColorsGradient()
                button.applyGradient(colors: gradientColors)
                button.applyShadow()
                button.setTitleColor(UIColor.white, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
                button.titleLabel?.textColor = UIColor.white
            }
        }
    }
}
