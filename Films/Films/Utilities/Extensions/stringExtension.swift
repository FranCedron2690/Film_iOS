//
//  viewControllerExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 11/1/22.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localization", bundle: Bundle.self.main, value: "", comment: "")
    }
}
