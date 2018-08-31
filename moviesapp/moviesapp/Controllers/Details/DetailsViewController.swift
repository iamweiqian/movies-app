//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Wei Qian on 31/08/2018.
//  Copyright © 2018 Yap Wei Qian. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieTitle: String? = ""
    var year: String? = ""
    var movieDescription: String? = ""
    var imageUrl: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = movieTitle
    }

}

extension DetailsViewController {
    
    private func setupView() {
        self.imageView.kf.setImage(with: URL(string: imageUrl!))
        self.titleLabel.text = movieTitle
        self.yearLabel.text = year
        self.descriptionLabel.text = movieDescription
    }
    
}
