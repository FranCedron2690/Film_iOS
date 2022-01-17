//
//  RoundBoxControlProtocol.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 13/1/22.
//

import Foundation
import UIKit

protocol RoundBoxControlProtocol {
    func commonInit() throws
    var leftIconImage: UIImage {get set}
    func setLeftImage() throws
}
