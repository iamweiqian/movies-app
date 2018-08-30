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
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: self.viewModel.items[indexPath.item].movie.posterUrl))
        let image = imageView.image ?? #imageLiteral(resourceName: "Polar Bear Pillow Case")
        let height = image.size.height
        
        return height
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.posterImageView.kf.setImage(with: URL(string: self.viewModel.items[indexPath.item].movie.posterUrl))
        return cell
    }
    
}
