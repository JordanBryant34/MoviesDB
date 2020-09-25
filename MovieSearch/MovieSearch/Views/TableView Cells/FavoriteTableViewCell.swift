//
//  FavoriteTableViewCell.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Updating Cell
    private func updateViews() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
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
