//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
    }
    
    private func setupViewModel() {
        
        self.viewModel.reloadHandler = {
            self.collectionView.reloadData()
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        self.viewModel.fetchItems { _ in
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }

}

extension MovieListViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let url = self.viewModel.items[indexPath.item].movie.posterUrl
        var image: UIImage = #imageLiteral(resourceName: "ImageNotFound")
        if !url.isEmpty {
            let imageData = try? Data(contentsOf: URL(string: url)!)
            if imageData != nil {
                image = UIImage(data: imageData!)!
            }
        }
        
        let numberOfColumns: CGFloat = 2
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        let height = (image.size.height / numberOfColumns) - (xInsets + cellSpacing)
        
        return height
    }
    
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let url = self.viewModel.items[indexPath.item].movie.posterUrl
        if !url.isEmpty {
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else {
            cell.posterImageView.image = #imageLiteral(resourceName: "ImageNotFound")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsViewController = DetailsViewController()
        detailsViewController.movieTitle = self.viewModel.items[indexPath.item].movie.title
        detailsViewController.year = self.viewModel.items[indexPath.item].movie.year
        detailsViewController.movieDescription = self.viewModel.items[indexPath.item].movie.storyline
        detailsViewController.imageUrl = self.viewModel.items[indexPath.item].movie.posterUrl
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
