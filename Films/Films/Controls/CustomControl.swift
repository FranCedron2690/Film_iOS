//
//  RoundBoxControl.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

class CustomControl: UIView {
    
    var nibName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName!, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return nil
        }
    }
    
    func xibSetup() {
        if self.subviews.isEmpty {
            if let view = loadViewFromNib() {
                view.frame = bounds
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(view)
            }
        }
    }
    
    func commonInit() {
        
    }
} 
