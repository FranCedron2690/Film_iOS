//
//  MovieCategoryTableViewCell.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import UIKit
import RxSwift

class MovieCategoryTableViewCell: UITableViewCell {
    
    //MARK: - Variables and init methods
    var selectedMovieDelegate: SelectedMovie?
    
    @IBOutlet private weak var titleSectionMovies: UILabel!
    @IBOutlet private weak var collectionMovies: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var categoryMovieSection: MovieCagegory?
    private var moviesInSection: MovieListModel?
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        collectionMovies.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CellNames.movieCell)
        
        isCollectionViewVisible (isVisible: false)
    }
    
    //MARK: - Receiving his category to show
    func setCategorySectionData (category: MovieCagegory) {
        categoryMovieSection = category
        
        titleSectionMovies.text = categoryMovieSection?.name
        
        donwloadSectionMoviesData ()
    }
    
    //MARK: - Download Data
    private func donwloadSectionMoviesData () {
        NetworkManager.instance.makeRequest(endpointToExecute: .getMoviesByCategory(idCategory: categoryMovieSection!.id)).subscribe { [weak self] response in
            do {
                self?.moviesInSection  = try JSONDecoder().decode(MovieListModel.self, from: response.data)
                
                self?.isCollectionViewVisible(isVisible: true)
                
                self?.reloadMovieCollection ()
            }
            catch {
                print ("Error decoding \(String(describing: self?.categoryMovieSection?.name)) category data: \(error)")
            }
        } onError: { [weak self] errorReceived in
            print ("Error decoding \(String(describing: self?.categoryMovieSection?.name)) category data: \(errorReceived)")
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Manage UI Screen
    private func isCollectionViewVisible (isVisible:Bool){
        
        if isVisible
        {
            activityIndicator.isHidden =  true
            activityIndicator.stopAnimating()
            collectionMovies.isHidden = false
        }
        else {
            activityIndicator.isHidden =  false
            activityIndicator.startAnimating()
            collectionMovies.isHidden = true
        }
    }
    
    private func reloadMovieCollection () {
        DispatchQueue.main.async {
            self.collectionMovies.reloadData()
        }
    }
    
    private func setMoviesToInitPosition (indexPath:IndexPath){
        DispatchQueue.main.async {
            self.collectionMovies.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

//MARK: - Extensions from CollectionView
extension MovieCategoryTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesInSection?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellNames.movieCell, for: indexPath) as! MovieCollectionViewCell
        
        if let safeImage = moviesInSection?.results[indexPath.row].posterPath {
            cell.setCachingImage(pathImage: safeImage)
        }
        
        return cell
    }
}

extension MovieCategoryTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idMovie = moviesInSection?.results[indexPath.row].id else { return }
        
        selectedMovieDelegate?.onSelectedMovie(movieID: idMovie)
    }
}
