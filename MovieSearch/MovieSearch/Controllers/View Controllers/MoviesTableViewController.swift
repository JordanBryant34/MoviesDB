//
//  MoviesTableViewController.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellId") as? MovieTableViewCell else { return UITableViewCell(frame: .zero) }
        let movie = movies[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let detailVC = segue.destination as? MovieDetailViewController else { return }
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            guard let selectedCell = tableView.cellForRow(at: selectedIndex) as? MovieTableViewCell else { return }
            let movie = movies[selectedIndex.row]
            
            detailVC.movie = movie
            detailVC.movieImage = selectedCell.posterImageView.image ?? UIImage(named: "noPosterImage")
        }
    }
}

extension MoviesTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        MovieController.searchMovies(searchText: searchText) { (result) in
            switch result {
                
            case .success(let movies):
                self.movies = movies
                self.tableView.reloadData()
                
                searchBar.text = ""
                self.view.endEditing(true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
