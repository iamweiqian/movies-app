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
    private var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViewModel()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
    }

}

extension MovieListViewController {
    
    func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        if let layout = self.collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func setupViewModel() {
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
    
    func setupRefreshControl() {
        self.refresher = UIRefreshControl()
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView.refreshControl = refresher
    }
    
    @objc func loadData(_ sender: Any) {
        self.viewModel.fetchItems { (_) in
            self.stopRefresher()
        }
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
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
        let labelViewHeight: CGFloat = 125
        let height = (image.size.height + labelViewHeight) / numberOfColumns
        
        return height
    }
    
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = self.viewModel.items[indexPath.item].movie.title
        cell.yearLabel.text = self.viewModel.items[indexPath.item].movie.year
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
