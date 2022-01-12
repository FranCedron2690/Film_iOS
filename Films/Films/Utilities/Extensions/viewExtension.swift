//
//  buttonExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(colors: [CGColor], isRouded: Bool = true) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        
        if isRouded {
            gradientLayer.cornerRadius = self.frame.height/2
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
}
