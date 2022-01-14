//
//  Styles.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

protocol GenericStyle {
    var hasShadow: Bool {get}
}

enum Styles {
    
    enum ColorGradients {
        case mainButtonGradient
        
        var gradientColors: [CGColor] {
            switch self {
            case .mainButtonGradient:
                return [UIColor.orange.cgColor, UIColor.tintColor.cgColor]
            }
        }
    }
    
    enum Labels: GenericStyle {
        case titleLabel
        case normalLabel
        case thinLabelInfo
        case errorLabel
        
        var hasShadow: Bool {
            switch self {
            case .titleLabel:
                return false
            case .normalLabel:
                return false
            case .thinLabelInfo:
                return false
            case .errorLabel:
                return false
            }
        }
        
        var font: UIFont {
            switch self {
            case .titleLabel:
                return UIFont.systemFont(ofSize: 22.0, weight: .bold)
            case .normalLabel:
                return UIFont.systemFont(ofSize: 17.0)
            case .thinLabelInfo:
                return UIFont.systemFont(ofSize: 12.0, weight: .light)
            case .errorLabel:
                return UIFont.systemFont(ofSize: 17.0)
            }
        }
        
        var colorFont: UIColor {
            switch self {
            case .titleLabel:
                return UIColor.black
            case .normalLabel:
                return UIColor.black
            case .thinLabelInfo:
                return UIColor.black
            case .errorLabel:
                return UIColor.red
            }
        }
//
//        var fontSize: CGFloat {
//            switch self {
//            case .titleLabel:
//                return 22
//            case .normalLabel:
//                return 17
//            case .thinLabelInfo:
//                return 12
//            case .errorLabel:
//                return 17
//            }
//        }
//
//        var fontWeight: UIFont.Weight {
//            switch self {
//            case .titleLabel:
//                return .bold
//            case .normalLabel:
//                return .medium
//            case .thinLabelInfo:
//                return .light
//            case .errorLabel:
//                return .medium
//            }
//        }
    }
    
    enum RoundBoxControls: GenericStyle {
        case textEdit
        case datePicker
        
        var BGColor: UIColor {
            switch self {
            case .textEdit:
                return UIColor.white
            case .datePicker:
                return UIColor.white
            }
        }
        
        var hasShadow: Bool {
            switch self {
            case .textEdit:
                return true
            case .datePicker:
                return true
            }
        }
    }
    
    enum Buttons: GenericStyle {
        case mainButton
        
        var gradientColors: [CGColor] {
            switch self {
            case .mainButton:
                return Styles.ColorGradients.mainButtonGradient.gradientColors
            }
        }
        
        var hasShadow: Bool {
            switch self {
            case .mainButton:
                return true
            }
        }
        
        var font: UIFont {
            switch self {
            case .mainButton:
                return UIFont.boldSystemFont(ofSize: 17.0)
            }
        }
        
        var colorFont: UIColor {
            switch self {
            case .mainButton:
                return UIColor.white
            }
        }

//        var fontSize: CGFloat {
//            switch self {
//            case .mainButton:
//                return 17.0
//            }
//        }
//
//        var fontWeight: UIFont.Weight {
//            switch self {
//            case .mainButton:
//                return .bold
//            }
//        }
    }
}
