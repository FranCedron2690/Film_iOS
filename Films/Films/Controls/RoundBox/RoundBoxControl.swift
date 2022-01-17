//
//  RoundBoxControl.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit

@IBDesignable
class RoundBoxControl: CustomControl, RoundBoxControlProtocol {
    
//    @IBOutlet weak var imageLeft: UIImageView!
//    @IBOutlet weak var contentView: UIView!
    
    enum ConstantsConstraints {
        static let imageSize: CGFloat = 25
        static let heightImageConstraint: CGFloat = 50
        static let widthImageConstraint: CGFloat = 55
    }

    @IBInspectable var leftIconImage: UIImage = UIImage() {
        didSet {
            do {
                try setLeftImage()
            } catch {}
        }
    }
    
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

    func setLeftImage() throws {
        fatalError("Sobreescribe este método en el control final para que asigne la imagen!!")
    }
    
    // Constraints padres de todos los controles!!
    func addImageLftConstraints (viewToAddContraints: UIView, viewReference: UIView) -> [NSLayoutConstraint] {
        viewToAddContraints.translatesAutoresizingMaskIntoConstraints = false
        let centerYConstraint = viewToAddContraints.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let heightConstraint = viewToAddContraints.heightAnchor.constraint(equalToConstant: ConstantsConstraints.imageSize)
        let widhtConstraint = viewToAddContraints.widthAnchor.constraint(equalToConstant: ConstantsConstraints.widthImageConstraint)
        let leadingConstraint = viewToAddContraints.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        
        return [centerYConstraint, heightConstraint, widhtConstraint, leadingConstraint]
    }
    
    func addContentConstraints (viewToAddContraints: UIView, viewReference: UIView) -> [NSLayoutConstraint] {
        viewToAddContraints.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = viewToAddContraints.heightAnchor.constraint(equalToConstant: ConstantsConstraints.heightImageConstraint)
        let topConstraint = viewToAddContraints.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let bottomConstraint = viewToAddContraints.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        let leadingConstraint = viewToAddContraints.leadingAnchor.constraint(equalTo: viewReference.trailingAnchor, constant: 10)
        let trailingConstraint = viewToAddContraints.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        
        return [heightConstraint, topConstraint, bottomConstraint, trailingConstraint, leadingConstraint]
    }
}
