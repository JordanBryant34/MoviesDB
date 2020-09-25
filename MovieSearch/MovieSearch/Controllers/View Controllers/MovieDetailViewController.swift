//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    var movieImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "N/A")"
        popularityLabel.text = "Popularity Score: \(movie.popularity ?? 0.0)"
        overviewLabel.text = movie.overview
        
        if let movieImage = movieImage {
            posterImageView.image = movieImage
        } else {
            posterImageView.image = UIImage(named: "noPosterImage")
        }
    }
}
