//
//  HomeViewModel.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 28/12/21.
//

import Foundation

class HomeViewModel: BaseViewModel {
    private weak var homeDelegate: HomeDelegate?

    init (homeDelegate: HomeDelegate) {
        self.homeDelegate = homeDelegate
    }

    func goToMovies () {
        homeDelegate?.onLoginOk()
    }
}
