//
//  RoundedBoxPasswordProtocol.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 17/1/22.
//

import Foundation
import UIKit

protocol RoundedBoxPasswordProtocol {
    var isPassword: Bool {get set}
    func setSecurityText()
    var placelolder: String {get set}
    func setPlaceholder()
}
