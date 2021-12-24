//
//  SelectedMovie.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation

protocol SelectedMovie: AnyObject {
    
    func onSelectedMovie (movieID: Int)
}
