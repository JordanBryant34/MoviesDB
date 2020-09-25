//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Properties
    var movie: Movie?
    var movieImage: UIImage?
    
    let movieController = MovieController.shared
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    //MARK: - Updating Views
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
        
        if movieController.favoriteMovies.contains(movie) {
            favoriteButton.setTitle("Unfavorite this movie", for: .normal)
        } else {
            favoriteButton.setTitle("Favorite this movie", for: .normal)
        }
        
        favoriteButton.layer.masksToBounds = true
        favoriteButton.layer.cornerRadius = 75/2
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let movie = movie else { return }
        if movieController.favoriteMovies.contains(movie) {
            movieController.unfavoriteMovie(movie: movie)
            favoriteButton.setTitle("Favorite this movie", for: .normal)
        } else {
            movieController.favoriteMovie(movie: movie)
            favoriteButton.setTitle("Unfavorite this movie", for: .normal)
        }
    }
}
