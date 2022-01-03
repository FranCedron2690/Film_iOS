//
//  MovieDetailViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import UIKit
class MovieDetailViewController: BaseViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valorationLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var pageMovieTextView: UITextView!
    @IBOutlet private weak var sinopsisTextView: UITextView!
    var movieID: Int?
    var viewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.downloadDataDelegate = self
        viewModel?.downloadMovieDetailData(movieID: movieID!)
    }
}

extension MovieDetailViewController: DownloadDataFromView {
    func onDownloadDataCorrect() {

        guard let movieData = viewModel?.movieData else { return }

        titleLabel.text = movieData.originalTitle
        valorationLabel.text = String(movieData.voteAverage)
        posterImage.downloadImageFrom(urlString: movieData.posterPath, defaultImage: "default-movie")
        releaseDateLabel.text = movieData.releaseDate

        let attributedString = NSMutableAttributedString(string: movieData.homepage)
        if let url = URL(string: movieData.homepage) {
            // Set the 'click here' substring to be the link
            attributedString.setAttributes([.link: url], range: NSRange(location: 0, length: movieData.homepage.count))
            pageMovieTextView.attributedText = attributedString
        }

        sinopsisTextView.text = movieData.overview
    }

    func onDownloadDataError(errorReceived: NetworkError) {
        showAlertError(errorMessage: errorReceived.localizedDescription)
        print("Error receiving data from id = \(String(describing: movieID)): typeError\(errorReceived.type) \(errorReceived.localizedDescription)")
    }
}
