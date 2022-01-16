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
        
        addAllConstraints()
        
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
    
    override func setLeftImage() {
        imageLeft.image = leftIconImage
    }
    
    func setTextlabelDescription() {
        labelDescription.text = textDescription
    }
}

// MARK: - Constraints
extension RoundedBoxDate {
    func addAllConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: addImageLftConstraints(viewToAddContraints: imageLeft, viewReference: contentView))
        constraints.append(contentsOf: addContentConstraints(viewToAddContraints: contentView, viewReference: imageLeft))
        constraints.append(contentsOf: addInternalConstraints())
        constraints.append(contentsOf: addContentLabelConstraints())
        NSLayoutConstraint.activate(constraints)
    }
    
    func addInternalConstraints () -> [NSLayoutConstraint] {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let topDatePickerConstraint = datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let bottomDatePickerConstraint = datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        let leadingDatePickerConstraint = datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        
        return [topDatePickerConstraint, bottomDatePickerConstraint, leadingDatePickerConstraint]
    }
    
    func addContentLabelConstraints() -> [NSLayoutConstraint] {
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        
        let topLabelConstraint = labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let bottomLabelConstraint = labelDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        let leadingLabelConstraint = labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        let trailingLabelConstraint = labelDescription.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: 10)
        
        return [topLabelConstraint, bottomLabelConstraint, leadingLabelConstraint, trailingLabelConstraint]
    }
}
