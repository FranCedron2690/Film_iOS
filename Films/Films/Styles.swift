//
//  Styles.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

enum Styles {
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
}
