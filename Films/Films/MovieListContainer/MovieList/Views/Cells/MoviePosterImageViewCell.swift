//
//  MovieCollectionViewCell.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 21/12/21.
//

import UIKit

class MoviePosterImageViewCell: UICollectionViewCell {

    // MARK: - Variables and init methods
    @IBOutlet weak var movieImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Download image poster Movie
    func setCachingImage (pathImage: String) {
        movieImage.downloadImageFrom(urlString: pathImage, defaultImage: "default-movie")
    }
}
