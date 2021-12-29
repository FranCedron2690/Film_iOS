//
//  imageExtension.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func downloadImageFrom (urlString: String, defaultImage: String){
        
        self.image = UIImage(named: defaultImage)
        
        let urlImage = MoviesService.baseAddresImages + urlString
        AF.request(urlImage).responseImage { [weak self] response in

            if case .success(let image) = response.result {
                self?.image = image
            }
            if case .failure(let errorReceived) = response.result {
                print("Error downloading image Poster: \(errorReceived)")
            }            
        }
    }
}
