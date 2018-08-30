//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import UIKit

typealias DataHandler = () -> Void

struct MovieCellModel {
    var movie: Movie
}

class MovieListViewModel {
    
    init() { }
    
    var items: [MovieCellModel] = []
    var reloadHandler: DataHandler = { }
    
    var itemCount: Int {
        return self.items.count
    }
    
    func item(_ indexPath: IndexPath) -> MovieCellModel {
        return self.items[indexPath.row]
    }
    
    func fetchItems(completion: @escaping (_ error: Error?) -> Void) {
        Movie.getMovieList { [weak self] (list, error) in
            if let error = error {
                print(error)
                completion(error)
            } else {
                print("TOTAL ITEMS: \(list.count)")
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                //                    self?.configureModels(list: list)
                //                })
                self?.configureModels(list: list)
                completion(nil)
            }
        }
    }
    
    private func configureModels(list: [Movie]) {
        self.items = list.map { MovieCellModel(movie: $0) }
        self.reloadHandler()
    }
    
}
