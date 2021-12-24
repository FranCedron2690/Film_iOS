//
//  BaseViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 24/12/21.
//

import Foundation
import RxSwift

class BaseViewModel {
    let disposeBag = DisposeBag()
    weak var downloadDataDelegate:DownloadDataFromView?
}
