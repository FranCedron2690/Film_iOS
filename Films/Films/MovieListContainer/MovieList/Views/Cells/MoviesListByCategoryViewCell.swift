//
//  MovieCategoryTableViewCell.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 22/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesListByCategoryViewCell: UITableViewCell {// swiftlint:disable force_cast
    // MARK: - Variables and init methods
    weak var selectedMoviePosterDelegate: SelectedMoviePoster?

    @IBOutlet private weak var titleSectionMovies: UILabel!
    @IBOutlet private weak var collectionMovies: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!

    private let viewModel = MoviesListByCategoryViewModel()
    private let disposeBag = DisposeBag()

    private enum StatesCell {
        case dataDownloaded
        case errorDowload
        case loading
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        collectionMovies.register(UINib(nibName: "MoviePosterImageViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: GlobalConstants.CellNames.movieCell)

        viewModel.downloadDataDelegate = self

        collectionMovies.rx.contentOffset.changed.subscribe { [weak self] pointData in
            self?.viewModel.categoryMovieSection?.scrollCategoryOffset = pointData
        }.disposed(by: disposeBag)

        manageStateCellUI(state: .loading)
    }

    // MARK: - Receiving his category to show
    func setCategorySectionData (_ category: MovieCagegory) {
        viewModel.categoryMovieSection = category
        viewModel.donwloadSectionMoviesData(idCategory: category.idCategory)

        collectionMovies.setContentOffset(category.scrollCategoryOffset, animated: false)

        titleSectionMovies.text = category.nameCategory
    }

    func getCategoryOffset () -> (nameCategory: String, offset: CGPoint)? {
        if let nameCategory = viewModel.categoryMovieSection?.nameCategory, let offset = viewModel.categoryMovieSection?.scrollCategoryOffset {
            return (nameCategory, offset)
        } else { return nil }
    }

    // MARK: - Manage UI Screen
    private func manageStateCellUI (state: StatesCell) {
        switch state {
        case .dataDownloaded:
            errorLabel.isHidden = true
            activityIndicator.isHidden =  true
            activityIndicator.stopAnimating()
            collectionMovies.isHidden = false
        case .errorDowload:
            errorLabel.isHidden = false
            activityIndicator.isHidden =  true
            activityIndicator.stopAnimating()
            collectionMovies.isHidden = true
        case .loading:
            errorLabel.isHidden = true
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

// MARK: - Extensions from CollectionView
extension MoviesListByCategoryViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataMoviesBySection?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConstants.CellNames.movieCell, for: indexPath) as! MoviePosterImageViewCell

        if let safeImage = viewModel.dataMoviesBySection?.results[indexPath.row].posterPath {
            cell.setCachingImage(pathImage: safeImage)
        }

        return cell
    }
}

extension MoviesListByCategoryViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idMovie = viewModel.dataMoviesBySection?.results[indexPath.row].id else { return }

        selectedMoviePosterDelegate?.onSelectedMoviePoster(movieID: idMovie)
    }
}

extension MoviesListByCategoryViewCell: DownloadDataFromView {
    func onDownloadDataCorrect() {
        manageStateCellUI(state: .dataDownloaded)
        reloadMovieCollection()
    }

    func onDownloadDataError(errorReceived: NetworkError) {
        manageStateCellUI(state: .errorDowload)
        print("Error receiving data from section \(String(describing: viewModel.categoryMovieSection?.nameCategory)): \(errorReceived) ")
    }
}
