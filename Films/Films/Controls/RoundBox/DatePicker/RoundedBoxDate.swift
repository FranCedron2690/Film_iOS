//
//  RoundedBoxDate.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 12/1/22.
//

import Foundation
import UIKit
import RxSwift

class RoundedBoxDate: RoundBoxControl, RoundedBoxDateProtocol {
    
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelDescription: UILabel!
    
    @IBInspectable var textDescription: String = String() {
        didSet {
            setTextlabelDescription()
        }
    }
    
    var dateString: String?
    
    private let disposeBag = DisposeBag()
    
    override func commonInit() {
        nibName = String(describing: type(of: self))
        xibSetup()
        addImageLftConstraints(viewToAddContraints: imageLeft, viewReference: contentView)
        addContentConstraints(viewToAddContraints: contentView, viewReference: imageLeft)
        
        datePicker.rx.date.changed.distinctUntilChanged().subscribe { [weak self] event in
            switch event {
            case .next(let date):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY/MM/dd"
                self?.dateString = dateFormatter.string(from: date)
            default:
                return
            }
        }.disposed(by: disposeBag)
    }
    
    func addImageLftConstraints (viewToAddContraints: UIView, viewReference: UIView) {
        viewToAddContraints.translatesAutoresizingMaskIntoConstraints = false
        let centerYImageView = viewToAddContraints.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let heightImageView = viewToAddContraints.heightAnchor.constraint(equalToConstant: 25)
        let widhtImageView = viewToAddContraints.widthAnchor.constraint(equalToConstant: 50)
        let leadingConstant = viewToAddContraints.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        var constraintsImage = [NSLayoutConstraint]()
        constraintsImage.append(contentsOf: [centerYImageView, heightImageView, widhtImageView, leadingConstant])
        NSLayoutConstraint.activate(constraintsImage)
    }
    
    func addContentConstraints (viewToAddContraints: UIView, viewReference: UIView) {
        viewToAddContraints.translatesAutoresizingMaskIntoConstraints = false
        let heightImageView = viewToAddContraints.heightAnchor.constraint(equalToConstant: 50)
        let topConstant = viewToAddContraints.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let bottomConstant = viewToAddContraints.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        let leadingConstant = viewToAddContraints.leadingAnchor.constraint(equalTo: viewReference.trailingAnchor, constant: 10)
        let trailingConstant = viewToAddContraints.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        
        var constraintsImage = [NSLayoutConstraint]()
        constraintsImage.append(contentsOf: [heightImageView, topConstant, bottomConstant, trailingConstant, leadingConstant])
        NSLayoutConstraint.activate(constraintsImage)
    }
    
    override func setTextEditLateralContainer(isLeft: Bool) {
        imageLeft.image = leftIconImage
    }
    
    func setTextlabelDescription() {
        labelDescription.text = textDescription
    }
}

extension RoundedBoxDate: UIPickerViewDelegate {
    
}
