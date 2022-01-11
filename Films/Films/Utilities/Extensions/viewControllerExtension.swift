//
//  viewControllerExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

extension UIViewController {
    func getStringTranslated(key: String) -> String {
        return NSLocalizedString(key, tableName: "Localization", bundle: Bundle.self.main, value: "", comment: "")
    }
}
