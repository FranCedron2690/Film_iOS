//
//  RoundBoxControl.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

class CustomControl: UIView, CustomControlProtocol {
    
    var nibName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        do {
            try commonInit()
        } catch {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        do {
            try commonInit()
        } catch {
            
        }
    }
    
    func commonInit() throws {
        fatalError("Debes sobreescribir este método, para establecer el nibName con y llamar en la siguiente linea a xibSetup()!!")
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
}
