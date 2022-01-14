//
//  CustomControlProtocol.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 13/1/22.
//

import Foundation
import UIKit

protocol CustomControlProtocol {
    var nibName: String? { get set }
    func commonInit() throws
    func loadViewFromNib() -> UIView?
    func xibSetup()
}
