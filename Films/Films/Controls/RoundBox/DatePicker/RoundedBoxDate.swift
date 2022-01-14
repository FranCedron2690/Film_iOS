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
    
    override func setTextEditLateralContainer(isLeft: Bool) {
        imageLeft.image = leftIconImage
    }
    
    func setTextlabelDescription() {
        labelDescription.text = textDescription
    }
}

extension RoundedBoxDate: UIPickerViewDelegate {
    
}
