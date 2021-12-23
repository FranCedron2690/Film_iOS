//
//  MovieDetailViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import UIKit
import RxSwift
class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valorationLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var pageMovieTextView: UITextView!
    @IBOutlet weak var sinopsisTextView: UITextView!
    var movieID: Int?
    
    let disposedBag = DisposeBag ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        downloadMovieDetailData ()
    }
    
    private func downloadMovieDetailData () {
        
        NetworkManager.instance.makeRequest(endpointToExecute: .getMovieByID(idMovie: movieID!)).subscribe { [weak self] response in
            do {
                let movieData = try JSONDecoder().decode(MovieModel.self, from: response.data)
                self?.titleLabel.text = movieData.originalTitle
                self?.valorationLabel.text = String(movieData.voteAverage)
                self?.posterImage.downloadImageFrom(urlString: movieData.posterPath, defaultImage: "default-movie")
                self?.releaseDateLabel.text = movieData.releaseDate
                
                let attributedString = NSMutableAttributedString(string: movieData.homepage)
                if let url = URL(string: movieData.homepage) {
                    // Set the 'click here' substring to be the link
                    attributedString.setAttributes([.link: url], range: NSMakeRange(0, movieData.homepage.count))
                    self?.pageMovieTextView.attributedText = attributedString
                }
                self?.sinopsisTextView.text = movieData.overview
            }
            catch {
                print ("Error decoding movie data receiving: \(error)")
            }
        } onError: { errorReceived in
            print ("Error decoding movie data receiving: \(errorReceived)")
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposedBag)
    }
}
