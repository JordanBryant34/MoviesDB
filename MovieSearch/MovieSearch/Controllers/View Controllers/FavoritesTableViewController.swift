//
//  FavoritesTableViewController.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    //MARK: - Properties
    let movieController = MovieController.shared
    
    //MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCellId") as? FavoriteTableViewCell else { return UITableViewCell(frame: .zero) }
        
        cell.movie = movieController.favoriteMovies[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    //MARK: - Segue Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFavoriteDetailVC" {
            guard let detailVC = segue.destination as? MovieDetailViewController else { return }
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            guard let selectedCell = tableView.cellForRow(at: selectedIndex) as? FavoriteTableViewCell else { return }
            let movie = movieController.favoriteMovies[selectedIndex.row]
            
            detailVC.movie = movie
            detailVC.movieImage = selectedCell.posterImageView.image ?? UIImage(named: "noPosterImage")
        }
    }
}
