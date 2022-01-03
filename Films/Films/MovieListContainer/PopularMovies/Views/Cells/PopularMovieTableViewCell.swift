//
//  PopularMovieTableViewCell.swift
//  
//
//  Created by fjcedron@hiberus.com on 23/12/21.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateReleasedLabel: UILabel!
    @IBOutlet weak var valorationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData (movieData: MoviesData) {
        posterImage.downloadImageFrom(urlString: movieData.posterPath, defaultImage: "default-movie")
        titleLabel.text = movieData.originalTitle
        dateReleasedLabel.text = movieData.releaseDate
        valorationLabel.text = String(movieData.voteAverage)
    }
}
