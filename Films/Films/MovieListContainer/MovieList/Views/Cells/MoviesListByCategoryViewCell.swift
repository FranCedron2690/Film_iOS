//
//  MovieCategoryTableViewCell.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesListByCategoryViewCell: UITableViewCell {
    
    //MARK: - Variables and init methods
    weak var selectedMoviePosterDelegate: SelectedMoviePoster?
    
    @IBOutlet private weak var titleSectionMovies: UILabel!
    @IBOutlet private weak var collectionMovies: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = MoviesListByCategoryViewModel()
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        collectionMovies.register(UINib(nibName: "MoviePosterImageViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CellNames.movieCell)
        
        viewModel.downloadDataDelegate = self
        
        collectionMovies.rx.contentOffset.changed.subscribe { [weak self] pointData in
            self?.viewModel.categoryMovieSection?.scrollCategoryOffset = pointData
        }.disposed(by: disposeBag)
        
        isCollectionViewVisible (isVisible: false)
    }
    
    //MARK: - Receiving his category to show
    func setCategorySectionData (_ category: MovieCagegory) {
        viewModel.categoryMovieSection = category
        viewModel.donwloadSectionMoviesData(idCategory: category.id)
        
        collectionMovies.setContentOffset(category.scrollCategoryOffset, animated: false)
        
        titleSectionMovies.text = category.name
    }
    
    func getCategoryOffset () -> (nameCategory:String,offset:CGPoint)? {
        if let nameCategory = viewModel.categoryMovieSection?.name, let offset = viewModel.categoryMovieSection?.scrollCategoryOffset {
            return (nameCategory, offset)
        }
        else { return nil }
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
}

//MARK: - Extensions from CollectionView
extension MoviesListByCategoryViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataMoviesBySection?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellNames.movieCell, for: indexPath) as! MoviePosterImageViewCell
        
        if let safeImage = viewModel.dataMoviesBySection?.results[indexPath.row].posterPath {
            cell.setCachingImage(pathImage: safeImage)
        }
        
        return cell
    }
}

extension MoviesListByCategoryViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idMovie = viewModel.dataMoviesBySection?.results[indexPath.row].id else { return }
        
        selectedMoviePosterDelegate?.onSelectedMoviePoster(movieID: idMovie)
    }
}

extension MoviesListByCategoryViewCell: DownloadDataFromView{
    func onDownloadDataCorrect() {
        isCollectionViewVisible(isVisible: true)
        reloadMovieCollection ()
    }
    
    func onDownloadDataError(errorReceived: Error) {
        print ("Error receiving data from section \(String(describing: viewModel.categoryMovieSection?.name)): \(errorReceived) ")
    }
}
