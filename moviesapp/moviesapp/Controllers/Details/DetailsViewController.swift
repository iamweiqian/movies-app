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

        imageView.kf.setImage(with: URL(string: imageUrl!))
        titleLabel.text = movieTitle
        yearLabel.text = year
        descriptionLabel.text = movieDescription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = movieTitle
    }

}
