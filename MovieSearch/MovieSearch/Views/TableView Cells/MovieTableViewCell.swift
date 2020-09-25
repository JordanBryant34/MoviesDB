//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.rating)"
        overviewLabel.text = movie.overview
        
        posterImageView.image = nil
        
        if let posterImagePath = movie.posterImagePath {
            MovieController.fetchImageForPath(imagePath: posterImagePath) { (result) in
                switch result {
                case .success(let image):
                    self.posterImageView.image = image
                case.failure(let error):
                    self.posterImageView.image = UIImage(named: "noPosterImage")
                    print(error.localizedDescription)
                }
            }
        } else {
            posterImageView.image = UIImage(named: "noPosterImage")
        }
        
    }
}
